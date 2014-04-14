package com.sparkmind.service;

import com.sparkmind.model.Contact;
import com.sparkmind.response.StatusResponse;

public interface ContactService {
	StatusResponse send(Contact message);
	StatusResponse sendMailUsingSpringJavaMail(String to, String subject, String body);
	StatusResponse sendPreConfiguredMailMessageUsingSpringJavaMail(String to, String dear, String content);
}
