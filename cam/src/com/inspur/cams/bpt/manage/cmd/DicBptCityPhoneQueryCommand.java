package com.inspur.cams.bpt.manage.cmd;

import org.loushang.next.dao.DaoFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;

import com.inspur.cams.bpt.base.data.DicBptCityPhone;

/**
 * @title:DicBptCityPhoneQueryCommand
 * @description:
 * @author:
 * @since:2011-09-20
 * @version:1.0
*/
public class DicBptCityPhoneQueryCommand extends BaseQueryCommand{

	public DataSet execute() {
		ParameterSet pset = getParameterSet();
		EntityDao<DicBptCityPhone> dao = (EntityDao<DicBptCityPhone>) DaoFactory
				.getDao("com.inspur.cams.bpt.base.dao.jdbc.DicBptCityPhoneDao");
		return dao.query(pset);
	}
}
