package com.vts.dms;

import java.io.CharArrayWriter;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;

public class CharArrayWriterResponse extends HttpServletResponseWrapper {

	private final CharArrayWriter charArray = new CharArrayWriter();

	public CharArrayWriterResponse(HttpServletResponse response) {
		super(response);
	}

	@Override
	public PrintWriter getWriter() throws IOException {
		return new PrintWriter(charArray);
	}

	public String getOutput() {
		return charArray.toString();
	}
}
