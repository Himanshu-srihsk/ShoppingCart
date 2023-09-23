function  add_to_cart(pid,pname,price){
    let cart = localStorage.getItem("cart");
    if(cart === null){
        //no cart yet
        let products=[];
        let product = {productId: pid,productName:pname,productQuantity:1,productPrice:price};
        products.push(product);
        localStorage.setItem("cart",JSON.stringify(products));
        //console.log("Product is added for the First time");
        showToast("Item is added to Cart");
    }else{
       //cart is already present 
       let pcart= JSON.parse(cart);
       let oldProduct= pcart.find((item)=>item.productId===pid);
       if(oldProduct){
           //we have to increase the quantity
           oldProduct.productQuantity=oldProduct.productQuantity +1;
           pcart.map((item)=>{
               if(item.productId === oldProduct.productId){
                   item.productQuantity =  oldProduct.productQuantity;
               }
           });
           localStorage.setItem("cart",JSON.stringify(pcart));
           //console.log("Product Quantity is Increased");
           showToast(oldProduct.productName +"Product Quantity is Increased with Quantity="+oldProduct.productQuantity);
       }else{
           //we have to add the quantity
           let product = {productId: pid,productName:pname,productQuantity:1,productPrice:price};
           pcart.push(product);
           localStorage.setItem("cart",JSON.stringify(pcart));
           //console.log("Product is added");
           showToast("Product is added to cart");
       }
    }
    UpdateCart();
}

function UpdateCart(){
    let cartstring =localStorage.getItem("cart");
    let cart= JSON.parse(cartstring);
    if(cart==null || cart.length==0){
        console.log("cart is Empty");
        $(".cart-items").html("( 0 )");
        $(".cart-body").html("<h3>Your Cart is Empty </h3>");
        $(".checkout-btn").attr('disabled',true);
    }else{
        console.log(cart);
        $(".cart-items").html(`(${cart.length})`);
        
        let table=`
        <table class='table'>
                    <thead class='thead-light'>
                         <tr>
                         <th> Item name</th>
                         <th> Price</th>
                         <th> Quantity</th>
                         <th> Total Price</th>
                         <th> Action </th>
                        </tr>
                    </thead>
                    `;
                   let TotalPrice=0;
                   cart.map((item)=>{
                       table +=`
                          <tr>
                           <td>${item.productName}</td>
                           <td>${item.productPrice}</td>
                           <td>${item.productQuantity}</td>
                           <td>${item.productQuantity*item.productPrice}</td>
                           <td><button onclick='deleteItemFromCart(${item.productId})' class='btn btn-danger btn-sm'>Remove</button></td>
                      
                           </tr> 
                         `
            TotalPrice+=item.productQuantity*item.productPrice;
                                                      
                   })
                
                    table=table+ `
                 <tr><td colspan='5' class ='text-right font-weight-bold m-5'>Total Price: ${TotalPrice}</td></tr>     
             </table>`
                    
                $(".cart-body").html(table);
                $(".checkout-btn").attr('disabled',false);
    }
}

function deleteItemFromCart(pid){
    let cart=JSON.parse(localStorage.getItem('cart'));
    let newcart= cart.filter((item)=> item.productId !== pid);
    localStorage.setItem('cart',JSON.stringify(newcart));
    UpdateCart();
    showToast("Item is removed from cart");
}

function goToCheckout(){
    window.location="checkout.jsp";
}


$(document).ready(function() {
    UpdateCart();
});


function showToast(content) {
  $("#toast").addClass("display");
  $("#toast").html(content);
  setTimeout(()=> {
      $("#toast").removeClass("display");
  },2000);
}