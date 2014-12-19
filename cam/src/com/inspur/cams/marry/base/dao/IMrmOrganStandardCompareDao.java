package com.inspur.cams.marry.base.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.marry.base.data.MrmOrganStandardCompare;

/**
 * @title:等级评定标准对照dao接口
 * @description:
 * @author:
 * @since:2012-11-21
 * @version:1.0
 */
public interface IMrmOrganStandardCompareDao extends BaseCURD<MrmOrganStandardCompare> {
	public void save(List<MrmOrganStandardCompare> list);
}
