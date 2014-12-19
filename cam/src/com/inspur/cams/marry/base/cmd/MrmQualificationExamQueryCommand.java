package com.inspur.cams.marry.base.cmd;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import org.loushang.sca.ScaComponentFactory;

import com.inspur.cams.marry.base.domain.IMrmQualificationExamDomain;

/**
 * @title:MrmQualificationExamQueryCommand
 * @description:
 * @author:
 * @since:2011-12-01
 * @version:1.0
*/
public class MrmQualificationExamQueryCommand extends BaseQueryCommand{
	private IMrmQualificationExamDomain iMrmQualificationExamDomain = ScaComponentFactory
	.getService(IMrmQualificationExamDomain.class,
			"MrmQualificationExamDomain/MrmQualificationExamDomain");
	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		
		return iMrmQualificationExamDomain.queryPersonExam(pset);
	}
	//导出
	public DataSet queryPersonExamExcel() {
		ParameterSet pset = getParameterSet();
		return iMrmQualificationExamDomain.queryPersonExamExcel(pset);
	}
}
