package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.base.data.BptContentNumMaintain;

/**
 * @title:IBptContentNumMaintainDao
 * @description:目录号维护
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
 public interface IBptContentNumMaintainDao extends BaseCURD<BptContentNumMaintain>{
	public void save(List<BptContentNumMaintain> list);
}

