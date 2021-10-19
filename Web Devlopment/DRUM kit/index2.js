// document.querySelector("button").addEventListener("click",handleclick);

//    function handleclick(){
//         alert("I got clicked");
//    }; 




// for mouse presses
   var drum=document.querySelectorAll("button");

   for(var i=0;i<drum.length;i++){
              drum[i].addEventListener("click", function(){
                   
               var curr=this.innerHTML;

               makesound(curr);
              // Aeffect(curr);

              });
   }


   //for keyboard presses

   document.addEventListener("keypress",function(event){
                 makesound(event.key);
                //Aeffect(event.key);
               
   });


   function makesound(key){
  
      Aeffect(key);
     switch (key) {
          case "w":      var aud= new Audio('sounds/tom-1.mp3');
                         aud.play();
                         break;

          case "a":      var aud= new Audio('sounds/tom-2.mp3');
                        aud.play();
                        break;
            
          case "s":      var aud= new Audio('sounds/tom-3.mp3');
                        aud.play();
                        break;

          case "d":      var aud= new Audio('sounds/tom-4.mp3');
                        aud.play();
                        break;
                        
          case "j":      var aud= new Audio('sounds/snare.mp3');
                        aud.play();
                        break;
                        
          case "k":      var aud= new Audio('sounds/crash.mp3');
                        aud.play();
                        break;
                        
          case "l":      var aud= new Audio('sounds/kick-bass.mp3');
                        aud.play();
                        break;
    
   }
}

function Aeffect(key){
        var btnn= document.querySelector("."+key);
      btnn.classList.add("pressed");

      setTimeout( function(){
              btnn.classList.remove("pressed");
      } ,100);
}