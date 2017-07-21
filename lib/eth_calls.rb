module Web3::EthCalls

  def eth_protocolVersion()
  raise NotImplementedError.new "JSON-RPC call to eth_protocolVersion is not currently supported"
  end

  def eth_syncing()
  response = do_request("eth_syncing")
  response["result"]
  end

  def eth_coinbase()
  response = do_request("eth_coinbase")
  response["result"]
  end

  def eth_mining()
  response = do_request("eth_mining")
  response["result"]
  end

  def eth_hashrate()
  response = do_request("eth_hashrate")
  to_decimal response["result"]
  end

  def eth_gasPrice()
  response = do_request("eth_gasPrice")
  to_decimal response["result"]
  end

  def eth_accounts()
  response = do_request("eth_accounts")
  response["result"]
  end

  def eth_blockNumber()
  response = do_request("eth_blockNumber")
  to_decimal response["result"]
  end

  def eth_getBalance(address, block = "latest")
  response = do_request("eth_getBalance",[address, block])
  to_decimal response["result"]
  end

  def eth_getStorageAt(storage_address, position, block = "latest")
  response = do_request("eth_getStorageAt",[storage_address, to_hex(position), block])
  response["result"]
  end

  def eth_getTransactionCount(address, block = "latest")
  response = do_request("eth_getTransactionCount",[address, block])
  to_decimal response["result"]
  end

  def eth_getBlockTransactionCountByHash(data)
  response = do_request("eth_getBlockTransactionCountByHash",[data])
  to_decimal response["result"]
  end

  def eth_getBlockTransactionCountByNumber(block = "latest")
  response = do_request("eth_getBlockTransactionCountByNumber",[block])
  to_decimal response["result"]
  end

  def eth_getUncleCountByBlockHash(data)
  response = do_request("eth_getUncleCountByBlockHash",[data])
  to_decimal response["result"]
  end

  def eth_getUncleCountByBlockNumber(data)
  response = do_request("eth_getUncleCountByBlockNumber",[data])
  to_decimal response["result"]
  end

  def eth_getCode(address, block = "latest")
  response = do_request("eth_getCode",[address, block])
  response["result"]
  end

  def eth_sign(address, data)
  response = do_request("eth_sign",[address, data])
  response["result"]
  end

  def eth_sendTransaction(transaction_object)
    response = do_request("eth_sendTransaction",[transaction_object])
    response["result"]
  end

  def eth_pendingTransactions()
    response = do_request("eth_pendingTransactions")
    response["result"]
  end

  def eth_resend(pending_transaction, gasPrice=nil, gasLimit=nil)
    package = [pending_transaction]
    if gasPrice != nil
      package += [gasPrice, gasLimit]
    end
    response = do_request("eth_resend", package)
    response["result"]
  end

  def eth_sendRawTransaction(data)
    response = do_request("eth_sendRawTransaction",[data])
    response["result"]
  end

  def eth_call(trans_object,block="latest")
    response = do_request("eth_call",[trans_object, block])
    response["result"]
  end

  def eth_estimateGasOld(trans_object)
    response = do_request("eth_estimateGas",[trans_object])
    response["result"]
  end

  def eth_estimateGasNew(from_address, to_address, ether, password, gas, gasPrice)
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
    response = do_request("eth_estimateGas",[trans])
    response["result"]
  end

  def eth_getBlockByHash(hash, full_transactions = true)
  response = do_request("eth_getBlockByHash",[hash, full_transactions])
  response["result"]
  end

  def eth_getBlockByNumber(number, full_transactions = true)
  response = do_request("eth_getBlockByNumber",[number, full_transactions])
  response["result"]
  end

  def eth_getTransactionByHash(hash)
  response = do_request("eth_getTransactionByHash",[hash])
  response["result"]
  end

  def eth_getTransactionByBlockHashAndIndex(hash, index)
  response = do_request("eth_getTransactionByBlockHashAndIndex",[hash, index])
  response["result"]
  end

  def eth_getTransactionByBlockNumberAndIndex(number, index)
  response = do_request("eth_getTransactionByBlockNumberAndIndex",[number, index])
  response["result"]
  end

  def eth_getTransactionReceipt(hash)
  response = do_request("eth_getTransactionReceipt",[hash])
  response["result"]
  end

  def eth_getUncleByBlockHashAndIndex(hash, index)
  response = do_request("eth_getUncleByBlockHashAndIndex",[hash, index])
  response["result"]
  end

  def eth_getUncleByBlockNumberAndIndex(number, index)
  response = do_request("eth_getUncleByBlockNumberAndIndex",[number, index])
  response["result"]
  end

  def eth_getCompilers()
  response = do_request("eth_getCompilers")
  response["result"]
  end

  def eth_compileLLL(code)
  response = do_request("eth_compileLLL",[code])
  response["result"]
  end

  def eth_compileSolidity(code)
  response = do_request("eth_compileSolidity",[code])
  response["result"]
  end

  def eth_compileSerpent(code)
  response = do_request("eth_compileSerpent",[code])
  response["result"]
  end

  def eth_newFilter(fromBlock, toBlock, address, topics)
  response = do_request("$CODE",[fromBlock, toBlock, address, topics])
  to_decimal response["result"]
  end

  def eth_newBlockFilter()
  response = do_request("eth_newBlockFilter")
  to_decimal response["result"]
  end

  def eth_newPendingTransactionFilter()
  response = do_request("eth_newPendingTransactionFilter")
  to_decimal response["result"]
  end

  def eth_uninstallFilter(id)
  response = do_request("eth_uninstallFilter",[id])
  response["result"]
  end

  def eth_getFilterChanges(id)
  response = do_request("eth_getFilterChanges",[id])
  response["result"]
  end

  def eth_getFilterLogs(id)
  response = do_request("eth_getFilterLogs",[id])
  response["result"]
  end

  def eth_getLogs(filter_obj)
  response = do_request("eth_getLogs",[filter_obj])
  response["result"]
  end

  def eth_getWork()
  response = do_request("eth_getWork")
  response["result"]
  end

  def eth_submitWork(nonce, powHash, mixDigest)
  response = do_request("eth_submitWork",[nonce, powHash, mixDigest])
  response["result"]
  end

  def eth_submitHashrate(hashrate, id)
  response = do_request("eth_submitHashrate",[hashrate, id])
  response["result"]
  end
end
