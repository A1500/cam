package com.inspur.cams.marry.person.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.person.data.Marryperson;

/**
 * @title: IMarrypersonDao
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
*/
 public interface IMarrypersonDao extends BaseCURD<Marryperson>{
	 public DataSet queryMarryPersons(ParameterSet pset);
	 public DataSet queryCertifierPersons(ParameterSet pset);
}

