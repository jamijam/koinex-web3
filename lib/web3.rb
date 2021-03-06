require "httparty"
require "json"

class Web3
  attr_accessor :address, :endpoint, :id, :debug

  @@jsonrpc = "2.0"
  @@debug = ENV["ETH_DEBUG"] || false

  
  def initialize( endpoint = ENV["ETH_ENDPOINT"] || "http://localhost:8545",
                  id = ENV["ETH_DEFAULT_CLIENT_ID"] || 999)
    @endpoint = endpoint
    @id = id
  end

  def do_request(method, params = [], id = @id)
    request_json = { :jsonrpc => @@jsonrpc,
               :method => method,
               :params => params,
               :id => @id
             }.to_json

    if @@debug
      puts "Request to " + @endpoint + ": " + request_json + "  ...."
    end

    response = HTTParty.post(@endpoint,
        :body => request_json,
        :headers => { 'Content-Type' => 'application/json' } )

    if @@debug
      puts "Response: " + response.to_s()
    end

    if response.bad_gateway?
      raise "Unable to connect to JSON-RPC endpont" + @endpoint
    end

    if !response.success?
      raise "JSON-RPC endpoint " + @endpoint + " returned http code " + response.code.to_s()
    end

    if response["error"]
      code = response["error"]["code"]
      message = response["error"]["message"]
      raise "In response to " + method + " request, JSON-RPC endpoint returned error #" + code.to_s() + ": " + message
    end
    response
  end

require_relative "web3_calls.rb"
include Web3::Web3Calls

require_relative "net_calls.rb"
include Web3::NetCalls

require_relative "eth_calls.rb"
include Web3::EthCalls

require_relative "shh_calls.rb"
include Web3::ShhCalls

require_relative "personal_calls.rb"
include Web3::PersonalCalls

require_relative "txpool_calls.rb"
include Web3::TxpoolCalls


#Utility methods

  # Converts a hex string or int to a decimal integer
  def to_decimal(hex)
    if hex == nil
      return nil
    end
    if hex.is_a?(Integer)
      return hex
    end
    hex.to_i(16)
  end

  # Converts a decimal integer to a hex string
  def to_hex(decimal)
    if decimal == nil
      return nil
    end
    if decimal.is_a?(String)
      return decimal
    end
    decimal.to_s(16) #this will throw an error if a non-integer is used
  end


  # Converts a decimal integer to a hex string that starts with a 0x marker
  def to_0x(decimal)
    "0x" + to_hex(decimal)
  end

  # Converts wei to ether
  def wei_to_ether(wei)
    1.0 * wei / 10**18
  end

  # Converts either to wei
  def ether_to_wei(ether)
    (ether * 10**18).round()
  end

  # Converts either to wei a hex-formatted string, including the 0x indicator
  def ether_to_0xwei(ether)
    to_0x(ether_to_wei(ether))
  end

  def ether_to_hexwei(ether)
    to_hex(ether_to_wei(ether))
  end

  # Convenience function to simply send ether from one account to another, using
  # the default gas settings.
  # This requires the personal api to be active. See https://github.com/ethereum/go-ethereum/wiki/Management-APIs
  def sendEther(from_address, to_address, ether, password, gas, gasPrice)
    trans = {}
    trans["from"] = from_address
    trans["to"] = to_address
    trans["value"] = ether_to_0xwei(ether)
    if gas != nil
      trans["gas"] = to_0x(gas) #should this to_hex or to_0x?
    end
    if gasPrice != nil
      trans["gasPrice"] = to_0x(gasPrice)
    end
    personal_signAndSendTransaction(trans, password)
  end

  def sendWei(from_address, to_address, wei, password, gas, gasPrice)
    trans = {}
    trans["from"] = from_address
    trans["to"] = to_address
    trans["value"] = to_0x(wei)
    if gas != nil
      trans["gas"] = to_0x(gas) #should this to_hex or to_0x?
    end
    if gasPrice != nil
      trans["gasPrice"] = to_0x(gasPrice)
    end
    personal_signAndSendTransaction(trans, password)
  end










end

w3 = Web3. new
#w3.address =
#puts w3. web3_clientVersion
#puts w3. net_version
#puts w3. eth_protocolVersion
#puts "ds"
#puts w3. eth_coinbase #testme
#puts w3. eth_getBlockTransactionCountByNumber 3267552
# w3. eth_getBlockTransactionCountByHash '0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238'

#puts w3. eth_blockNumber
#puts w3. eth_mining
#puts w3. eth_getTransactionCount
#puts w3. eth_getBalance
#puts w3. eth_accounts
#puts w3. eth_gasPrice
#puts do_request(@method, @params)
