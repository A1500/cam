package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.base.data.BptStateChange;

/**
 * @title:IBptStateChangeDao
 * @description:
 * @author:
 * @since:2011-05-25
 * @version:1.0
*/
 public interface IBptStateChangeDao extends BaseCURD<BptStateChange>{
	public void save(List<BptStateChange> list);
	public void updateStateChange(BptStateChange bptStateChange);
	public void updateClass(BptStateChange bptStateChange);
	/**
	 * 获取最新的变更前信息
	 * @return
	 */
	public String queryPreStateChange(String peopleId);
}

