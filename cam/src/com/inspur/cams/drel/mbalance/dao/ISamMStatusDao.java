package com.inspur.cams.drel.mbalance.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.mbalance.data.SamMStatus;

/**
 * @title:ISamMedicalStatusDao
 * @description:救助状态Dao接口
 * @author:luguos
 * @since:2011-06-01
 * @version:1.0
*/
 public interface ISamMStatusDao extends BaseCURD<SamMStatus>{
	 /**
	  * 保存救助状态信息
	  */
	public void save(List<SamMStatus> list);
	 /**
	  * 保存救助状态信息
	  */
	public void updateAss(SamMStatus samMStatus);
}

