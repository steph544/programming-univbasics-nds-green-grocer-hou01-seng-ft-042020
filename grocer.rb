require 'pp'
require 'pry'

def find_item_by_name_in_collection(name, collection)
  element_level=0
  while element_level<collection.length do 
    if collection[element_level][:item]==name 
      return collection[element_level]
    end
  element_level+=1
end 
end 

def consolidate_cart(cart)
  newcart=[]
  element_index=0 
  while element_index<cart.length 
    x=find_item_by_name_in_collection(cart[element_index][:item], newcart)
    if x != nil
      x[:count] +=1
    else
      newcart << {:item=>cart[element_index][:item], :price=>cart[element_index][:price],:clearance=>cart[element_index][:clearance], :count => 1}
  end
  element_index+=1 
end
newcart
end 


def apply_coupons(cart, coupons)
counter=0 
while counter < coupons.length
cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
couponed_item_name= "#{coupons[counter][:item]} W/COUPON"
cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
if cart_item && cart_item[:count] >= coupons[counter][:num]
  if cart_item_with_coupon
    cart_item_with_coupon[:count] += coupons[counter][:num]
    cart_item[:count] -= coupons[counter][:num]
  else 
    cart_item_with_coupon = {
    :item => couponed_item_name, 
    :price => coupons[counter][:cost]/coupons[counter][:num],
    :count => coupons[counter][:num],
    :clearance => cart_item[:clearance]
  }
    cart << cart_item_with_coupon
    cart_item[:count] -= coupons[counter][:num]
    end 
  end 
  counter+=1 
end
cart 
end

def apply_clearance(cart)
  counter=0 
  while counter < cart.length
  if cart[counter][:clearance] == true
    cart[counter][:price] = (cart[counter][:price] - (cart[counter][:price] * 0.2 )).round(2)
  end
  counter+=1
end
  cart
end

def checkout(cart, coupons)
newcart=consolidate_cart(cart)
binding.pry 
apply_coupons(newcart,coupons)
apply_clearance(newcart)
counter=0 
total=0 
when counter<newcart.length do 
total+=(newcart[counter][:price] * newcart[counter][:count]).round(2)
counter+=1 
end

if total > 100
  total * 0.9
end

total 
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
