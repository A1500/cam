package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice;

/**
 * @title:IBptApplyDisabilityNoticeDao
 * @description:
 * @author:
 * @since:2011-05-18
 * @version:1.0
*/
public interface IBptApplyDisabilityNoticeDao extends BaseCURD<BptApplyDisabilityNotice>{
	public void save(List<BptApplyDisabilityNotice> list);
}

