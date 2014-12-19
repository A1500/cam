package com.inspur.cams.marry.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.RecordToBeanUtil;
import com.inspur.cams.marry.base.dao.IMrmOrganStandardDao;
import com.inspur.cams.marry.base.data.MrmOrganStandard;
import com.inspur.cams.marry.base.domain.IMrmOrganStandardDomain;

/**
 * @title:等级评定标准domain
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public class MrmOrganStandardDomain implements IMrmOrganStandardDomain {
	@Reference
	private IMrmOrganStandardDao mrmOrganStandardDao;

	public DataSet query(ParameterSet pset) {
		return mrmOrganStandardDao.query(pset);
	}

	public DataSet getMrmOrganStandard(ParameterSet pset) {
		return RecordToBeanUtil.uppercaseToLowercase(mrmOrganStandardDao
				.getMrmOrganStandard(pset));
	}

	public void batchUpdate(List<MrmOrganStandard> list) {
		mrmOrganStandardDao.batchUpdate(list);
	}

	public void insert(MrmOrganStandard mrmOrganStandard) {
		mrmOrganStandardDao.insert(mrmOrganStandard);
	}

	public void update(MrmOrganStandard mrmOrganStandard) {
		mrmOrganStandardDao.update(mrmOrganStandard);
	}
}
