package com.inspur.cams.drel.mbalance.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.drel.mbalance.data.SamMedicalTopLine;
/***
 * 一站结算_救助封顶线dao接口
 * @author yanliangliang
 * @date 2011-6-15
 */
public interface ISamMedicalTopLineDao extends BaseCURD<SamMedicalTopLine> {
	public void save(List<SamMedicalTopLine> list);
}
