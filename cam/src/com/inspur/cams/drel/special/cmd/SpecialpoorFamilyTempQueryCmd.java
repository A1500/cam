package com.inspur.cams.drel.special.cmd;

import org.loushang.sca.ScaComponentFactory;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.web.cmd.BaseQueryCommand;
import com.inspur.cams.drel.special.domain.ISpecialpoorFamilyTempDomain;

/**
 * SpecialpoorFamilyTempQueryCmd
 * @description:
 * @author:
 * @since:2013-08-09
 * @version:1.0
*/
 public class SpecialpoorFamilyTempQueryCmd extends BaseQueryCommand{
	 private ISpecialpoorFamilyTempDomain specialpoorFamilyTempDomain = ScaComponentFactory.getService(ISpecialpoorFamilyTempDomain.class, "specialpoorFamilyTempDomain/specialpoorFamilyTempDomain");
		public DataSet execute() {
			ParameterSet pset = getParameterSet();
			return specialpoorFamilyTempDomain.query(pset);
		}
	}
