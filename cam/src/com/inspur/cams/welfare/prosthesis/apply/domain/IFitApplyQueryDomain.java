package com.inspur.cams.welfare.prosthesis.apply.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

public interface IFitApplyQueryDomain {

	public DataSet queryQualificationList(ParameterSet pset);
	public DataSet queryQualificationPrintList(ParameterSet pset);

}
