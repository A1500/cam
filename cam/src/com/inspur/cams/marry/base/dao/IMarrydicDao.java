package com.inspur.cams.marry.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.marry.base.data.Marrydic;

/**
 * @title:IMarrydicDao
 * @description:
 * @author:
 * @since:2011-07-13
 * @version:1.0
 */
public interface IMarrydicDao extends BaseCURD<Marrydic> {
	//获取字典缓存信息
	public DataSet getCacheDic(ParameterSet ps);
}
