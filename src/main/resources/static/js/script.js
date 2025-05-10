function addToProgress(prog) {
  if (prog.checked) {
    let counterSpan = document.getElementById('progress');
    let currentValue = parseInt(counterSpan.innerText, 10);
    currentValue += 1;
  	counterSpan.innerText = currentValue;
	
  }
}

function ChangeStyle(star){
	if (star.style.color === "yellow") {
	        star.style.color = "gray";
	    } else {
	        star.style.color = "yellow";
	    }
}

function addPoints() {  
    let counterSpan = document.getElementById('totPoints');
    let currentValue = parseInt(counterSpan.innerText, 10);
    currentValue += 1;
  	counterSpan.innerText = currentValue;  
}

function  myFunction(){
	const dueDates = document.querySelectorAll('.dueDate');
	const titles = document.querySelectorAll('.dueDateTitle');
	const today = new Date().toISOString().split('T')[0];
		
	const notificationArea = document.getElementById('notifications');

	    for (let i = 0; i < dueDates.length; i++) {
	        let due = dueDates[i].innerText.trim();
	        let title = titles[i].innerText.trim();
				
	        if (due === today) {
	            let alert = document.createElement("div");
	            alert.className = "alert alert-warning alert-dismissible fade show notificationDeco";
	            alert.role = "alert";
				alert.style.position = "fixed";
				alert.style.top = "50px";
				alert.style.right = "50px";
				alert.style.zIndex = "1050"; 
				alert.style.maxWidth = "300px";
	            alert.innerHTML = `
	                <strong>Reminder:</strong> "${title}" is due today!
	                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	            `;
	            notificationArea.appendChild(alert);
				setTimeout(() => {
					alert.remove();
				}, 2000);
	        }
	    }
		let counterSpan = document.getElementById('totPoints');	
		let currentValue = parseInt(counterSpan.innerText, 10);
		
		if (currentValue % 20 === 0 && currentValue !== 0) {
		    let congra = document.createElement("div");
		    congra.className = "alert alert-success alert-dismissible fade show";
		    congra.role = "alert";

		    // Centered on top styling
		    congra.style.position = "fixed";
		    congra.style.top = "30px";
		    congra.style.left = "50%";
		    congra.style.transform = "translateX(-50%)";
		    congra.style.zIndex = "1050";
		    congra.style.maxWidth = "400px";
		    congra.style.textAlign = "center";
		    congra.style.fontSize = "1.1rem";
		    congra.style.boxShadow = "0px 0px 10px rgba(0,0,0,0.2)";

		    congra.innerHTML = `
		        🎉 <strong>Congratulations!</strong> You've reached ${currentValue} points!
		        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    `;

		    document.body.appendChild(congra);

		    // Auto remove after 5 seconds
		    setTimeout(() => {
		        congra.remove();
		    }, 5000);
		}

}




function commentButton(){
	var x = document.getElementById("myComment");
	  if (x.style.display === "none") {
	    x.style.display = "block";
	  } else {
	    x.style.display = "none";
	  }
}

function showPopup() {
    const el = document.getElementById('popupBox');
    if (el) el.style.display = 'block';
}

function closePopup() {
	const el = document.getElementById('popupBox');
    if (el) el.style.display = 'none';
}


function isCongra(newPoints,totalPoints){	
	totalPoints = totalPoints % 20;	
	const updatedTotal = totalPoints + newPoints;
	if (updatedTotal >= 20) {
	        localStorage.setItem("showCongrats", "true");
	    }	
}

window.addEventListener("load", () => {
    if (localStorage.getItem("showCongrats") === "true") {
        showCongratsAlert();
        localStorage.removeItem("showCongrats");
    }
});


function showCongratsAlert() {
    let congra = document.createElement("div");
    congra.className = "alert alert-success alert-dismissible fade show";
    congra.role = "alert";

    congra.style.position = "fixed";
    congra.style.top = "30px";
    congra.style.left = "50%";
    congra.style.transform = "translateX(-50%)";
    congra.style.zIndex = "1050";
    congra.style.maxWidth = "600px";
    congra.style.textAlign = "center";
    congra.style.fontSize = "24px";
    congra.style.boxShadow = "0px 0px 10px rgba(0,0,0,0.2)";

    congra.innerHTML = `
        🎉 <strong>Congratulations!</strong> You've earned 20 new points! Go to your admin 
		<strong>You've earned a reward!</strong> 🎁
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;

    document.body.appendChild(congra);

    setTimeout(() => {
        congra.remove();
    }, 5000);
}

function getDiff(){
	const isHard = document.getElementById("hard").checked;
	const isMedium = document.getElementById("medium").checked;
	const isEasy = document.getElementById("easy").checked;
		
	let chorePoint = document.getElementById("chorePoint");
	
	if(isHard){
		chorePoint.max = 20;
		chorePoint.min = 10;
	}
	
	if(isMedium){
		chorePoint.max = 9;
		chorePoint.min = 6;
	}
		
	if(isEasy){
		chorePoint.max = 5;
		chorePoint.min = 1;
	}
}
