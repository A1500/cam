package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.base.data.DisabilityIdentification;

/**
 * @title:IDisabilityIdentificationDao
 * @description:
 * @author:
 * @since:2011-05-18
 * @version:1.0
*/
 public interface IDisabilityIdentificationDao extends BaseCURD<DisabilityIdentification>{
	public void save(List<DisabilityIdentification> list);
	/**
	 * 获得编号最后三位的最大值
	 */
	 public String getMaxNumber(String idPre);
}

