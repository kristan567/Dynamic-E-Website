/**
 * 
 */
function showLoginForm(){
		console.log("clickedddd");
    document.querySelector(".register-box").classList.remove("showRegister");
    document.querySelector(".overlay").classList.remove("showOverlay");

    document.querySelector(".login-box").classList.add("showLogin");
    document.querySelector(".overlay").classList.add("showOverlay");

}

function showRegisterForm(){
    document.querySelector(".login-box").classList.remove("showLogin");
    document.querySelector(".overlay").classList.remove("showOverlay");

    document.querySelector(".register-box").classList.add("showRegister");
    document.querySelector(".overlay").classList.add("showOverlay");
}

function removeModal(){
    document.querySelector(".login-box").classList.remove("showLogin");
    document.querySelector(".overlay").classList.remove("showOverlay");
    document.querySelector(".register-box").classList.remove("showRegister");
}

var hidden = true
function viewPassword(){
    if(hidden){
        document.querySelector(".hide-pw-gogs").classList.add("slide-gogs");
        document.getElementById("password").setAttribute('type','text');
        hidden = false
    }else{
        document.querySelector(".hide-pw-gogs").classList.remove("slide-gogs");
        document.getElementById("password").setAttribute('type','password');
        hidden = true
    }
    
}

function removeInvalidModal(){
     document.querySelector(".errorMessage").classList.add("errorMessageRemove");
     document.querySelector(".errorMessageOverlay").classList.add("errorMessageOverlayRemove");
	console.log("click")
}

function removeSuccessModal(){
     document.querySelector(".successMessage").classList.add("successMessageRemove");
     document.querySelector(".successMessageOverlay").classList.add("successMessageOverlayRemove");	
}

function showPopup(code, name, description, category, gender, stock, price, photo, brand){
   var popup = document.getElementById("popup");
   var popup_form = document.getElementById("popup-form");
   var popup_main = document.getElementById("popup-main");
   popup.innerHTML = " <h2>" + name +"</h2> <img src='http://localhost:8080/images/Products/" +photo+"'. alt="+ name +"> <p class='description'>" +description +"</p> <p class='category'>Category: " + category +"</p> <p class='gender'>Gender: "+gender+"</p><p class='stock'>Stock: "+stock+"</p><p class = 'price'>Price: NPR "+price+"</p><p class = 'brand'>Brand:"+brand+"</p>";
   popup_form.innerHTML = "<input type='text' name = 'product_code' value='"+code +"' style ='display: none;'><input type='number' name = 'product_quantity' placeholder = 'set Quantity' required><br><br><input type='submit' value = 'Add To Cart'></form>";
   popup_main.style.display = "block";
   
   document.querySelector(".popup-main").classList.add("popup-show");
   document.querySelector(".product-overlay").classList.add("show-product-overlay");
   console.log("click")
 }
 
function removeProductOverlay(){
	document.querySelector(".popup-main").classList.remove("popup-show");
    document.querySelector(".product-overlay").classList.remove("show-product-overlay");
      console.log("click")
	
}


