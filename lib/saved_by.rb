module SavedBy
  def save_new_by(user_id, ip)
    self.created_by = user_id
    self.created_ip = ip.to_s
    save_update_by(user_id, ip)
  end

  def save_update_by(user_id, ip)
    self.updated_by = user_id
    self.updated_ip = ip.to_s
    save
  end
end