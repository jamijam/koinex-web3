module Web3::TxpoolCalls

  def txpool_status()
  response = do_request("txpool_status")
  response["result"]
  end

end
