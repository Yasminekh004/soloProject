package com.codingdojo.chorestrackerpro.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.codingdojo.chorestrackerpro.models.User;

@Component
public class UserValidator implements Validator {

	@Override
	public boolean supports(Class<?> c) {
		return User.class.equals(c);
	}

	@Override
	public void validate(Object object, Errors errors) {
		User user = (User) object;

		if (!user.getConfirm().equals(user.getPassword())) {
			errors.rejectValue("confirm", "Match");
		}
	}
}