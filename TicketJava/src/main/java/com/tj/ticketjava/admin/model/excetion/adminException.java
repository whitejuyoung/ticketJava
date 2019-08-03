package com.tj.ticketjava.admin.model.excetion;

public class adminException extends RuntimeException{

	public adminException() {
		super();
	}

	public adminException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public adminException(String message, Throwable cause) {
		super(message, cause);
	}

	public adminException(String message) {
		super(message);
	}

	public adminException(Throwable cause) {
		super(cause);
	}

}
