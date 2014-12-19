package com.inspur.cams.marry.base.dao.jdbc;

import java.math.BigDecimal;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;

import com.inspur.cams.marry.base.dao.IMrmRegisAreaDao;
import com.inspur.cams.marry.base.data.MrmRegisArea;

/**
 * @title:MrmRegisAreaDao
 * @description:
 * @author:
 * @since:2011-11-26
 * @version:1.0
 */
public class MrmRegisAreaDao extends EntityDao<MrmRegisArea> implements
		IMrmRegisAreaDao {
	 private static final String  VALUE_ONE="01";
	 private static final String  VALUE_TWO="02";
	 private static final String  VALUE_THREE="03";
	 private static final String  VALUE_FOUR="04";
	 private static final String  VALUE_FIVE="05";
	 private static final String  VALUE_SEX="06";
	 private static final String  VALUE_SEVEN="07";
	 private static final String  VALUE_EIGHT="08";
	 private static final String  VALUE_NINE="09";
	 private static final String  VALUE_TEN="10";
	 private static final String  VALUE_ELEVEN="11";
	 private static final String  VALUE_TWELVE="12";
	public MrmRegisAreaDao() throws Exception {
		this.setDataSource(DataSourceFactory.defaultFactory
				.getDataSource("dataSource"));
		this.afterPropertiesSet();
	}

	@Override
	public Class getEntityClass() {
		return MrmRegisArea.class;
	}

	public void deleteByMrmRegisOrganInfo(String fkId) {
		StringBuffer delsql=new  StringBuffer("delete from  MRM_REGIS_AREA where ORGAN_ID= ? ");
		executeUpdate(delsql.toString(), new int[]{Types.VARCHAR}, new Object[]{fkId});
		
	}
	/*
	
	public void batchDeleteByMrmRegisOrganInfo(String[] fkId) {
		String[] sql = new String[fkId.length];
		for (int i = 0; i < fkId.length; i++) {
			sql[i] = "delete from MRM_REGIS_AREA where ORGAN_ID='" + fkId[i]
					+ "'";
		}
		batchUpdate(sql);
	}
*/
	public BigDecimal getMarryArea(String deptId) {// 候登区面积+结婚登记区面积的和
		String sql = "select sum(a.function_area) AS FUNCTION_AREA from mrm_regis_area a where a.dept_id= ? and a.function_name in ("+VALUE_ONE+","+VALUE_TWO+","+VALUE_EIGHT+")";
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal marryArea = new BigDecimal(0);
		if (list.size() > 0) {
			marryArea = (BigDecimal) ((Map) list.get(0)).get("FUNCTION_AREA");
		}
		return marryArea;
	}

	public BigDecimal getLhArea(String deptId) {// 离婚登记区面积
		String sql = "select a.function_area from mrm_regis_area a where a.dept_id= ?  and a.function_name="+VALUE_THREE;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal lhArea = new BigDecimal(0);
		if (list.size() > 0) {
			lhArea = (BigDecimal) ((Map) list.get(0)).get("FUNCTION_AREA");
		}
		return lhArea;
	}

	public BigDecimal getLhWindow(String deptId) {// 离婚登记区窗口
		String sql = "select a.window_num from mrm_regis_area a where a.dept_id= ?  and a.function_name="+VALUE_THREE;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal lhArea = new BigDecimal(0);
		if (list.size() > 0) {
			lhArea = (BigDecimal) ((Map) list.get(0)).get("WINDOW_NUM");
		}
		return lhArea;
	}

	public BigDecimal getMarryWindow(String deptId) {// 结婚登记区窗口数
		String sql = "select a.window_num from mrm_regis_area a where a.dept_id= ?  and a.function_name="+VALUE_TWO;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal marryWindow = new BigDecimal(0);
		if (list.size() > 0) {
			marryWindow = (BigDecimal) ((Map) list.get(0)).get("WINDOW_NUM");
		}
		return marryWindow;
	}

	public BigDecimal getHdChair(String deptId) {// 候登区座椅
		String sql = "select a.chair_num from mrm_regis_area a where a.dept_id= ?  and a.function_name="+VALUE_ONE;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal hdChair = new BigDecimal(0);
		if (list.size() > 0) {
			hdChair = (BigDecimal) ((Map) list.get(0)).get("CHAIR_NUM");
		}
		return hdChair;
	}

	public List getFdsArea(String deptId) {// 婚姻家庭辅导室、间数
		String sql = "select a.function_area,a.jian_shu from mrm_regis_area a where a.dept_id= ?  and a.function_name="+VALUE_FIVE;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		return list;
	}

	public BigDecimal getBzdtArea(String deptId) {// 颁证大厅面积
		String sql = "select a.function_area from mrm_regis_area a where a.dept_id= ?  and a.function_name="+VALUE_FOUR;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal bzdtArea = new BigDecimal(0);
		if (list.size() > 0) {
			bzdtArea = (BigDecimal) ((Map) list.get(0)).get("FUNCTION_AREA");
		}
		return bzdtArea;
	}

	public BigDecimal getTbChair(String deptId) {// 填表区座椅
		String sql = "select a.chair_num from mrm_regis_area a where a.dept_id= ?  and a.function_name="+VALUE_EIGHT;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal hdChair = new BigDecimal(0);
		if (list.size() > 0) {
			hdChair = (BigDecimal) ((Map) list.get(0)).get("CHAIR_NUM");
		}
		return hdChair;
	}
	
	public BigDecimal getBzChair(String deptId) {// 颁证区座椅（亲友观礼席）
		String sql = "select a.chair_num from mrm_regis_area a where a.dept_id= ?  and a.function_name="+VALUE_FOUR;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal hdChair = new BigDecimal(0);
		if (list.size() > 0) {
			hdChair = (BigDecimal) ((Map) list.get(0)).get("CHAIR_NUM");
		}
		return hdChair;
	}

	public String getdnDyjCard(String deptId) {// 电脑、打印机 、身份识别系统
		String sql = "select sum(a.computer_num) as computer,sum(a.printer_num) as printer,sum(a.cardreader_num) as cardreader from mrm_regis_area a where a.dept_id= ? ";
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal dn = new BigDecimal(0);
		BigDecimal dyj = new BigDecimal(0);
		BigDecimal card = new BigDecimal(0);
		if (list.size() > 0) {
			dn = (BigDecimal) ((Map) list.get(0)).get("COMPUTER")==null?new BigDecimal(0):(BigDecimal) ((Map) list.get(0)).get("COMPUTER");
		}
		if (list.size() > 0) {
			dyj = (BigDecimal) ((Map) list.get(0)).get("PRINTER")==null?new BigDecimal(0):(BigDecimal) ((Map) list.get(0)).get("PRINTER");
		}
		if (list.size() > 0) {
			card = (BigDecimal) ((Map) list.get(0)).get("CARDREADER")==null?new BigDecimal(0):(BigDecimal) ((Map) list.get(0)).get("CARDREADER");
		}
		return dn.toString() + "," + dyj.toString() + "," + card.toString();
	}

	// 卫生间位置
	public String getWcStation(String deptId) {
		String sql = "select t.area_station from mrm_regis_area t where t.dept_id=? and t.function_name="+VALUE_NINE;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		String wcStation = "";
		if (list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				wcStation += (String) ((Map) list.get(i)).get("AREA_STATION");				
			}
		}
		return wcStation;
	}

	public BigDecimal getCountArea(String deptId) {// 获得各登记处、省、市面积
		String sql = "";
		String deptCode = "";
		if ("00".equals(deptId.substring(4, 6))
				&& !"99".equals(deptId.substring(6, 8))) {// 市级单位
			deptCode = deptId.substring(0, 4) + "%";
			sql = "select sum(a.function_area) as SUM_AREA from mrm_regis_area a where a.dept_id like ? ";
		} else {// 县级单位
			deptCode = deptId;
			sql = "select sum(a.function_area) as SUM_AREA from mrm_regis_area a where a.dept_id= ? ";
		}

		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptCode });
		BigDecimal sumArea = new BigDecimal(0);
		if (list.size() > 0) {
			sumArea = (BigDecimal) ((Map) list.get(0)).get("SUM_AREA");
		}
		return sumArea;
	}
	
	// 有无 无障碍通道
	public BigDecimal getWzatd(String deptId) {
		String sql = "select t.FUNCTION_AREA from mrm_regis_area t where t.dept_id=? and t.function_name="+VALUE_ELEVEN;
		List list = this.executeQuery(sql, new int[] { Types.VARCHAR },
				new Object[] { deptId });
		BigDecimal wzatd = new BigDecimal(0);
		if (list.size() > 0) {
			wzatd = (BigDecimal) ((Map) list.get(0)).get("FUNCTION_AREA");
		}
		return wzatd;
	}

}
