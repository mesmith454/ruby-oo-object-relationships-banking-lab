require 'pry'

class Transfer
  attr_reader :sender, :receiver
  attr_accessor :amount, :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end
  def valid?
    if self.sender.valid? && self.receiver.valid?
      true
    else
      false
    end
  end
  

  def execute_transaction  
    if self.status == "pending" && self.sender.status == "open" && self.receiver.status == "open"      
      if self.sender.balance < self.amount        
        rejected  
      else        
        self.sender.balance -= self.amount        
        self.receiver.deposit(self.amount)        
        self.status = "complete"      
      end    
    else
      def rejected
        self.status = "rejected"  
        statement "Transaction rejected. Please check your account balance." 
      end
     
      def reverse_transfer
        if self.status == "complete"
          self.receiver.balance -= self.amount
          self.sender.deposit(self.amount)
          self.status = "reversed"
        end
      end
end
