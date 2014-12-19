package com.inspur.cams.marry.base.domain;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmOrganStandardCompare;

/**
 * @title:等级评定标准对照domain接口
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public interface IMrmOrganStandardCompareDomain {
	public DataSet query(ParameterSet pset);


	public void batchUpdate(List<MrmOrganStandardCompare> list);

	public void insert(MrmOrganStandardCompare mrmOrganStandardCompare);

	public void update(MrmOrganStandardCompare mrmOrganStandardCompare);
}
