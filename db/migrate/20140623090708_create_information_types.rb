class CreateInformationTypes < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default
    if direction == :up
      InformationType.create!(name: '首页-头条')
      InformationType.create!(name: '首页-新房速递')
      InformationType.create!(name: '首页-楼盘优惠')
      InformationType.create!(name: '首页-市场报告')
      InformationType.create!(name: '首页-今日话题')
      InformationType.create!(name: '首页-楼市资讯')
      InformationType.create!(name: '首页-楼市观点')
      InformationType.create!(name: '首页-活动')
      InformationType.create!(name: '首页-购房须知')
      InformationType.create!(name: '首页-购房警示')
      InformationType.create!(name: '首页-购房指南')
      InformationType.create!(name: '首页-楼盘评测')
      InformationType.create!(name: '首页-房事八卦')
      InformationType.create!(name: '首页-家居轶事')
      InformationType.create!(name: '首页-楼盘活动')
    end
  end
  
  def change
    create_table :information_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
