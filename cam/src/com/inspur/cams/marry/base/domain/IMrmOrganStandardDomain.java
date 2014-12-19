package com.inspur.cams.marry.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmOrganStandard;

/**
 * @title:等级评定标准domain接口
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public interface IMrmOrganStandardDomain {
	public DataSet query(ParameterSet pset);

	public DataSet getMrmOrganStandard(ParameterSet pset);

	public void batchUpdate(List<MrmOrganStandard> list);

	public void insert(MrmOrganStandard mrmOrganStandard);

	public void update(MrmOrganStandard mrmOrganStandard);
}
