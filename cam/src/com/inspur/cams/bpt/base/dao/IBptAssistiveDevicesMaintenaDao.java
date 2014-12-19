package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.base.data.BptAssistiveDevicesMaintena;

/**
 * @title:IBptAssistiveDevicesMaintenaDao
 * @description:伤残辅助器械
 * @author:
 * @since:2011-05-31
 * @version:1.0
*/
 public interface IBptAssistiveDevicesMaintenaDao extends BaseCURD<BptAssistiveDevicesMaintena>{
	public void save(List<BptAssistiveDevicesMaintena> list);
}

