package com.inspur.cams.drel.special.cmd;

import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.sca.ScaComponentFactory;
import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.special.domain.ISpecPeopleDomain;

/**
 * SpecialpoorPeopleQueryCmd
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
*/
 public class SpecialpoorPeopleQueryCmd extends  BaseQueryCommand{
		private ISpecPeopleDomain specPeopleDomain = ScaComponentFactory.getService
			(ISpecPeopleDomain.class, "specPeopleDomain/specPeopleDomain");
		public DataSet execute() {
			ParameterSet pset = getParameterSet();
			return specPeopleDomain.query(pset);
		}
	}
