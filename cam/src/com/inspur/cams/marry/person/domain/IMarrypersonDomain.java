package com.inspur.cams.marry.person.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

/**
 * @title: IMarrypersonDomain
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public interface IMarrypersonDomain {
	public DataSet query(ParameterSet pset);
	public DataSet queryMarryPersons(ParameterSet pset);
	public DataSet queryCertifierPersons(ParameterSet pset);
}