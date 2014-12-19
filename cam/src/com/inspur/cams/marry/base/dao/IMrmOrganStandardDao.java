package com.inspur.cams.marry.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.MrmOrganStandard;

/**
 * @title:等级评定标准dao接口
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public interface IMrmOrganStandardDao extends BaseCURD<MrmOrganStandard> {
	public void save(List<MrmOrganStandard> list);
	public DataSet getMrmOrganStandard(ParameterSet pset);
}
