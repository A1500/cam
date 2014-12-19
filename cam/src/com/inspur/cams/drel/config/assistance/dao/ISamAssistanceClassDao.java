package com.inspur.cams.drel.config.assistance.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.drel.config.assistance.data.SamAssistanceClass;

/**
 * @title:分类施保配置dao接口
 * @description:
 * @author:
 * @since:2012-05-02
 * @version:1.0
 */
public interface ISamAssistanceClassDao extends BaseCURD<SamAssistanceClass> {

	public SamAssistanceClass getClassMoney(ParameterSet pset);
}
