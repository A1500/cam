package com.inspur.cams.drel.mbalance.dao;

import java.util.List;
import java.util.Map;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.mbalance.data.SamMedicalConConfig;

/**
 * @title:ISamMedicalConConfigDao
 * @description:一站结算_医保系统连接配置Dao接口
 * @author:路国隋
 * @since:2011-09-27
 * @version:1.0
 */
public interface ISamMedicalConConfigDao extends BaseCURD<SamMedicalConConfig> {
	public void save(List<SamMedicalConConfig> list);

	/**
	 * 查询接口URL
	 * 
	 * @param organId 医院ID ，insuranceType 医疗保险类型
	 */
	public Map queryConConfig(String organId,String insuranceType);
}
