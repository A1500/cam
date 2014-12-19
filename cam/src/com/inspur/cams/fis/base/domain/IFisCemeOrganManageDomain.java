package com.inspur.cams.fis.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.fis.base.data.FisFuneralOrganManage;

public interface IFisCemeOrganManageDomain {

	public DataSet query(ParameterSet pset);
}
