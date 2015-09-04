#! /usr/bin/env ruby

require 'aws/kclrb'
require 'base64'
require 'zlib'
require 'stringio'
require 'json'
require 'dogapi'

class OrenoRecordProcessor < Aws::KCLrb::RecordProcessorBase
  def initialize()
    @datadog_api_key = ENV['DATADOG_API_KEY']
  end

  def init_processor(shard_id)
  end

  def process_records(records, checkpointer)
    last_seq = nil
    records.each do |record|
      begin
        events = JSON.parse(Zlib::GzipReader.new(StringIO.new(Base64.decode64(record['data']))).read)
        events['logEvents'].each do |event|
          puts "Rejected the #{event['extractedFields']['dstport']} port access from #{event['extractedFields']['srcaddr']}"
          emit_to_datadog("Rejected the #{event['extractedFields']['dstport']} port access from #{event['extractedFields']['srcaddr']}", event['extractedFields']['end'])
        end
        last_seq = record['sequenceNumber']
      rescue => e
        STDERR.puts "#{e}: Failed to process record '#{record}'"
      end
    end
    checkpoint_helper(checkpointer, last_seq)  if last_seq
  end

  def emit_to_datadog(msg,timestamp)
    dog = Dogapi::Client.new(@datadog_api_key)
    dog.emit_event(Dogapi::Event.new(msg, :msg_title => "VPC-Flow-Log Check", :alert_type => "error", :date_happened => timestamp))
  end

  def shutdown(checkpointer, reason)
    checkpoint_helper(checkpointer)  if 'TERMINATE' == reason
  ensure
    # Make sure to cleanup state
  end

  private

  def checkpoint_helper(checkpointer, sequence_number=nil)
    begin
      checkpointer.checkpoint(sequence_number)
    rescue Aws::KCLrb::CheckpointError => e
      checkpointer.checkpoint(sequence_number) if sequence_number
    end
  end
end

if __FILE__ == $0
  record_processor = OrenoRecordProcessor.new
  driver = Aws::KCLrb::KCLProcess.new(record_processor)
  driver.run
end
