package rest;

import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import javax.ws.rs.ext.ExceptionMapper;
import javax.ws.rs.ext.Provider;

@Provider
public class MyExceptionMapper implements ExceptionMapper<InvalidIdException> {
	@Override
	public Response toResponse(InvalidIdException exception) {
		return Response
				.status(Status.BAD_REQUEST)
				.entity(exception.getMessage())
				.type(MediaType.TEXT_PLAIN)
				.build();
	}
}
