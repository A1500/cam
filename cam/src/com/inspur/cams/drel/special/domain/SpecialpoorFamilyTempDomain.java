package com.inspur.cams.drel.special.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.drel.special.dao.ISpecialpoorFamilyTempDao;
/**
 * @title:SamBankAccountDomain
 * @description:
 * @author:
 * @since:2012-05-18
 * @version:1.0
*/
public class SpecialpoorFamilyTempDomain implements ISpecialpoorFamilyTempDomain {
	@Reference
	private ISpecialpoorFamilyTempDao specialpoorFamilyTempDao;

	public DataSet query(ParameterSet pset) {
		return specialpoorFamilyTempDao.query(pset);
	}

}
