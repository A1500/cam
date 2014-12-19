package com.inspur.cams.marry.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.marry.base.dao.IMrmOrganStandardCompareDao;
import com.inspur.cams.marry.base.data.MrmOrganStandardCompare;
import com.inspur.cams.marry.base.domain.IMrmOrganStandardCompareDomain;

/**
 * @title:等级评定标准对照domain
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public class MrmOrganStandardCompareDomain implements IMrmOrganStandardCompareDomain {
	@Reference
	private IMrmOrganStandardCompareDao mrmOrganStandardCompareDao;

	public DataSet query(ParameterSet pset) {
		return mrmOrganStandardCompareDao.query(pset);
	}


	public void batchUpdate(List<MrmOrganStandardCompare> list) {
		mrmOrganStandardCompareDao.batchUpdate(list);
	}

	public void insert(MrmOrganStandardCompare mrmOrganStandardCompare) {
		mrmOrganStandardCompareDao.insert(mrmOrganStandardCompare);
	}

	public void update(MrmOrganStandardCompare mrmOrganStandardCompare) {
		mrmOrganStandardCompareDao.update(mrmOrganStandardCompare);
	}
}
