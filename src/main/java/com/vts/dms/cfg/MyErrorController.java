package com.vts.dms.cfg;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyErrorController implements ErrorController {
	@RequestMapping("/error")
	public String handleError(HttpServletRequest req) {
		Object status = req.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

		if (status != null) {
			Integer statusCode = Integer.valueOf(status.toString());

			if (statusCode == HttpStatus.NOT_FOUND.value()) {
				req.setAttribute("ErrorMsg", "404");
			} else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
				req.setAttribute("ErrorMsg", "500");
			} else {
				req.setAttribute("ErrorMsg", "500");
			}
		}
		return "static/Error";
	}

	public String getErrorPath() {
		return "/error";
	}
}