
const firstNameSelector = document.getElementById('firstNameSelector');
const display = firstNameSelector.querySelector('.js-display');
const edit = firstNameSelector.querySelector('.js-edit');

firstNameSelector.addEventListener('click', event => {
	const updateBtn = event.target.closest('.update-btn');
	const saveBtn = event.target.closest('.save-btn');
  if (updateBtn) {
    display.classList.add('hide');
    edit.classList.remove('hide');
  } else if (saveBtn) {
    display.classList.remove('hide');
    edit.classList.add('hide');
    const updatedName = edit.querySelector('input[name="firstName"]').value;
    display.querySelector('.firstName').textContent = updatedName;
  }
});