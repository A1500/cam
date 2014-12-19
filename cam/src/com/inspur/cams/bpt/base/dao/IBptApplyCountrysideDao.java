package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.base.data.BptApplyCountryside;

/**
 * @title:IBptApplyCountrysideDao
 * @description:在乡复员军人【带病回乡退伍军人】审批
 * @author:
 * @since:2011-06-16
 * @version:1.0
*/
 public interface IBptApplyCountrysideDao extends BaseCURD<BptApplyCountryside>{
	public void save(List<BptApplyCountryside> list);
}

