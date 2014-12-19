package com.inspur.cams.marry.reg.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.reg.domain.IMarryregDomain;

/**
 * @title:MarryregQueryCommand
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public class MarryregQueryCommand extends BaseQueryCommand {

	public DataSet execute() {
		IMarryregDomain marryregDomain = ScaComponentFactory.getService(
				IMarryregDomain.class, "MarryregDomain/MarryregDomain");

		ParameterSet pset = getParameterSet();
		return marryregDomain.query(pset);
	}
}