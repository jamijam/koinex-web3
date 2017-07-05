module Web3::PersonalCalls

  def personal_listAccounts()
  response = do_request("personal_listAccounts")
  response["result"]
  end

  def personal_importRawKey(key, passphrase)
  response = do_request("personal_importRawKey",[key, passphrase])
  response["result"]
  end

  def personal_newAccount(password)
  response = do_request("personal_newAccount",[password])
  response["result"]
  end

  def personal_signAndSendTransaction(transaction, passphrase)
  response = do_request("personal_signAndSendTransaction",[transaction, passphrase])
  response["result"]
  end

  def personal_lockAccount(account)
  response = do_request("personal_lockAccount",[account])
  response["result"]
  end

  def personal_unlockAccount(account, passphrase, duration)
  response = do_request("personal_unlockAccount",[account, passphrase, duration])
  response["result"]
  end

  def personal_sign(message, account, password)
  response = do_request("personal_sign",[message, account, password])
  response["result"]
  end

  def personal_ecRecover(message, signature)
  response = do_request("personal_ecRecover",[message, signature])
  response["result"]
  end

end
