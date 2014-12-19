package com.inspur.cams.drel.mbalance.dao;

import java.util.List;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.mbalance.data.SamMedicalSpPer;
/***
 * 一站结算_优抚救助比例dao接口
 * @author yanliangliang
 * @date 2011-6-15
 */
public interface ISamMedicalSpPerDao extends  BaseCURD<SamMedicalSpPer>{
	public void save(List<SamMedicalSpPer> list);
}
