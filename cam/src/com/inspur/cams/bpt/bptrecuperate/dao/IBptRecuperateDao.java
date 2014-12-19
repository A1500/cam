package com.inspur.cams.bpt.bptrecuperate.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.bptrecuperate.data.BptRecuperate;

/**
 * @title:IBptRecuperateDao
 * @description:
 * @author:
 * @since:2011-11-09
 * @version:1.0
*/
 public interface IBptRecuperateDao extends BaseCURD<BptRecuperate>{
	
     public void save(List<BptRecuperate> list);
	 /**
	  * 更新该批次轮养休养人数
	  */
     public void updatePeopleCount(String batchId,int count,boolean flag);
}

