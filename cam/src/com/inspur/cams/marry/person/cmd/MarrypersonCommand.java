package com.inspur.cams.marry.person.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.*;
import com.inspur.cams.marry.person.domain.IMarrypersonDomain;

/**
 * @title: MarrypersonCommand
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarrypersonCommand extends BaseQueryCommand {

	IMarrypersonDomain marrypersonDomain = ScaComponentFactory.getService(
			IMarrypersonDomain.class, "MarrypersonDomain/MarrypersonDomain");

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		DataSet ds = marrypersonDomain.query(pset);
		return ds;
	}
	public DataSet queryMarryPersons(){
		ParameterSet pset = getParameterSet();
		DataSet ds = marrypersonDomain.queryMarryPersons(pset);
		return ds;
	}
	public DataSet queryCertifierPersons(){
		ParameterSet pset = getParameterSet();
		DataSet ds = marrypersonDomain.queryCertifierPersons(pset);
		return ds;
	}
	
}