package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr;

/**
 * @title:IBptApplyAssistiveDevicesPrDao
 * @description:
 * @author:
 * @since:2011-06-07
 * @version:1.0
*/
 public interface IBptApplyAssistiveDevicesPrDao extends BaseCURD<BptApplyAssistiveDevicesPr>{
	public void save(List<BptApplyAssistiveDevicesPr> list);
}

