function disableIfChecked(prog) {
  if (prog.checked) {
    prog.disabled = true;
    let counterSpan = document.getElementById('progress');
    let currentValue = parseInt(counterSpan.innerText, 10);
    currentValue += 1;
  	counterSpan.innerText = currentValue;
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
		
		
}