class CreateEvaluations < ActiveRecord::Migration
  def change    
  	create_table :evaluations do |t|      
  		t.integer :response_id

  		t.timestamps  
  	end  
  end
 end