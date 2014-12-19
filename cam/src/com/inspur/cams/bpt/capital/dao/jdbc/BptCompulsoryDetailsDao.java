package com.inspur.cams.bpt.capital.dao.jdbc;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.next.data.Record;
import org.loushang.persistent.jdbc.core.ResultReader;
import org.loushang.persistent.jdbc.core.SqlParameter;
import org.loushang.persistent.jdbc.datasource.DataSourceFactory;
import org.loushang.persistent.jdbc.object.Procedure;

import com.inspur.cams.bpt.capital.dao.IBptCompulsoryDetailsDao;
import com.inspur.cams.bpt.capital.data.BptCompulsoryDetails;

/**
 * @title:优待金发放发放名册 Dao 层 接口
 * @description:
 */
public class BptCompulsoryDetailsDao extends EntityDao<BptCompulsoryDetails> implements IBptCompulsoryDetailsDao {

 	public BptCompulsoryDetailsDao() throws Exception {
			this.setDataSource(DataSourceFactory.defaultFactory.getDataSource("dataSource"));
			this.afterPropertiesSet();
	}
	
	@Override
	public Class<BptCompulsoryDetails> getEntityClass() {
		return BptCompulsoryDetails.class;
	}
	
	public void deleteStruAll() {
		executeUpdate("delete from BptCompulsoryDetails");
	}
	
	private static class Proc extends Procedure {

        public Proc(DataSource ds) {

            super(ds, "BP_BPT_NONCOMPULSORY_GRANT");
            // 声明参数
            declareParameter(new SqlParameter("XZQH", Types.VARCHAR));
            declareParameter(new SqlParameter("FFSJ_Q", Types.VARCHAR));
            declareParameter(new SqlParameter("FFSJ_Z", Types.VARCHAR));
            declareParameter(new SqlParameter("MCID", Types.VARCHAR));
            /*declareParameter(new SqlOutParameter("V_STANDARD_FLAG", Types.VARCHAR));
            declareParameter(new SqlOutParameter("V_COUNT_FLAG", Types.VARCHAR));*/
            // 声明结果集的个数
            setNumberOfResultSet(0);
            compile();
        }

        public Map call(String xzqh, String ffsj_q, String ffsj_z,String mcid) {
            Map in = new HashMap();
            // 设置入参的值，key要和声明参数的名称一致
            in.put("XZQH", xzqh);
            in.put("FFSJ_Q", ffsj_q);
            in.put("FFSJ_Z", ffsj_z);
            in.put("MCID", mcid);
            ResultReader resultReader = new ResultReaderImpl() {
                protected Object mapRow(ResultSet rs, int rowNum) throws SQLException {
                    /*Record record = new Record();
                    record.set("REG_DETAIL_ID", rs.getString("REG_DETAIL_ID"));
                    record.set("REGISTER_ID", rs.getString("REGISTER_ID"));
                    record.set("PEOPLE_ID", rs.getString("PEOPLE_ID"));
                    
                    record.set("DOMICILE_CODE", rs.getString("DOMICILE_CODE"));
                    record.set("DOMICILE_NAME", rs.getString("DOMICILE_NAME"));
                    record.set("NAME", rs.getString("NAME"));
                    
                    record.set("OBJECT_TYPE_CODE", rs.getString("OBJECT_TYPE_CODE"));
                    record.set("ID_CARD", rs.getString("ID_CARD"));
                    record.set("ACCOUNT_CODE", rs.getString("ACCOUNT_CODE"));
                    
                    record.set("DOMICILE_TYPE", rs.getString("DOMICILE_TYPE"));
                    record.set("GRANT_MON", rs.getString("GRANT_MON"));
                    record.set("NOTE", rs.getString("NOTE"));
                    return record;*/
                	HashMap map = new HashMap();
					return map;
                }
            };
            ResultReader[] readerA = new ResultReader[] { resultReader };
            Map ret = execute(in);
            //ret.put("results", resultReader.getResults());
            return ret;
        }
    }

    private  Proc procduce = null;

    protected  void initDao() {
    	super.initDao();
        if (procduce == null) {
            procduce = new Proc(getDataSource());
        }
    }

	/**
	 * 除义务兵家庭外其他优抚对象优待金发放添加生成明细
	 */
	public void queryNonCompulsoryGenerateData(ParameterSet pset){
			String xzqh = pset.getParameter("xzqh").toString();
			xzqh = xzqh.substring(0,6);
			String ffsj_q = pset.getParameter("ffsj_q").toString();
			String ffsj_z = pset.getParameter("ffsj_z").toString();
			String mcid = (String)pset.getParameter("mcid");
			Map ret = procduce.call(xzqh,ffsj_q,ffsj_z,mcid);
	        /*DataSet set = new DataSet();
	        List results = null;
	        Object object = null;
	        String standardFlag = procduce.call(xzqh,ffsj_q,ffsj_z,mcid).get("V_STANDARD_FLAG").toString();
	        //String countFlag = procduce.call(xzqh,ffsj_q,ffsj_z,mcid).get("V_COUNT_FLAG").toString();
	        if("1".equals(standardFlag)){
	        	return set;
	        }else{
	        	object = procduce.call(xzqh,ffsj_q,ffsj_z,mcid).get("results");
		        if (object instanceof ArrayList) {
		            results = (List) object;
		            for (Object o : results) {
		                set.add((Record) o);
		            }
		        }
		        return set;
	        }*/
	}
	
	/**
	 * 查询义务兵优待金发放列表
	 */
	@SuppressWarnings("unchecked")
	public DataSet queryCompulsoryGrantList(ParameterSet pset){
		String organCode = pset.getParameter("organCode").toString();
		List typeList = new ArrayList();
		List<Object> argsList = new ArrayList();
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT D.REG_DETAIL_ID, D.PEOPLE_ID,\n");
		sql.append("       M.NAME || N.NAME || T.NAME AS DOMICILENAME, D.BELONG_YEAR, C.NAME,\n"); 
		sql.append("       C.ID_CARD, C.ACCOUNT_CODE, C.CONSCRIPT_DATE, C.DOMICILE_TYPE,\n"); 
		sql.append("       D.GRANT_MON, D.IN_TIBET_ADDITIONAL, D.MERIT_ADDITIONAL,\n"); 
		sql.append("       D.OTHER_ADDITIONAL, D.RECEIVE_NAME, D.TOTAL, D.GRANT_NUMBER\n"); 
		sql.append("  FROM BPT_COMPULSORY_DETAILS D, BPT_COMPULSORY C, DIC_CITY T, DIC_CITY M,\n"); 
		sql.append("       DIC_CITY N\n"); 
		sql.append(" WHERE D.PEOPLE_ID = C.ID AND C.DOMICILE_CODE = T.ID AND\n"); 
		sql.append("       SUBSTR(DOMICILE_CODE, 1, 4) || '00000000' = M.ID AND\n"); 
		sql.append("       SUBSTR(DOMICILE_CODE, 1, 6) || '000000' = N.ID");

		if (pset.getParameter("domicileCode") != null && !pset.getParameter("domicileCode").equals("")) {
			String domicileCode = pset.getParameter("domicileCode").toString();
			if (!domicileCode.substring(0, 2).equals("00") && domicileCode.substring(3, 5).equals("00")) {
				sql.append(" AND  SUBSTR(DOMICILE_CODE,1,2)= ? ");// 省局
				domicileCode = domicileCode.substring(0, 2);
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode);
			}else if(!domicileCode.substring(3, 5).equals("00")&&domicileCode.substring(5, 7).equals("00")){
				sql.append(" AND SUBSTR(DOMICILE_CODE,1,4)= ? ");//市局
				domicileCode = domicileCode.substring(0, 4);
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode);
			}else{
				sql.append(" AND SUBSTR(DOMICILE_CODE,1,6)= ? ");//区县
				domicileCode = domicileCode.substring(0, 6);
				typeList.add(Types.VARCHAR);
				argsList.add(domicileCode);
			}
		}else{
			if (!organCode.substring(0, 2).equals("00") && organCode.substring(3, 5).equals("00")) {
				sql.append(" AND  SUBSTR(DOMICILE_CODE,1,2)= ? ");// 省局
				organCode = organCode.substring(0, 2);
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}else if(!organCode.substring(3, 5).equals("00")&&organCode.substring(5, 7).equals("00")){
				sql.append(" AND SUBSTR(DOMICILE_CODE,1,4)= ? ");//市局
				organCode = organCode.substring(0, 4);
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}else{
				sql.append(" AND SUBSTR(DOMICILE_CODE,1,6)= ? ");//区县
				organCode = organCode.substring(0, 6);
				typeList.add(Types.VARCHAR);
				argsList.add(organCode);
			}
		}
		
		if(pset.getParameter("name")!=null&&!pset.getParameter("name").equals("")){
			String name = pset.getParameter("name").toString();
			sql.append("AND C.NAME LIKE ? ");
			name = "%"+name+"%";
			typeList.add(Types.VARCHAR);
			argsList.add(name);
		}
		if(pset.getParameter("idCard")!=null&&!pset.getParameter("idCard").equals("")){
			String idCard = pset.getParameter("idCard").toString();
			sql.append("AND C.ID_CARD = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(idCard);
		}
		if(pset.getParameter("domicileType")!=null&&!pset.getParameter("domicileType").equals("")){
			String domicileType = pset.getParameter("domicileType").toString();
			sql.append("AND C.DOMICILE_TYPE = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(domicileType);
		}
		if(pset.getParameter("belongYear")!=null&&!pset.getParameter("belongYear").equals("")){
			String belongYear = pset.getParameter("belongYear").toString();
			sql.append("AND D.BELONG_YEAR = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(belongYear);
		}
		if(pset.getParameter("composedPortrait")!=null&&!pset.getParameter("composedPortrait").equals("")){
			String composedPortrait = pset.getParameter("composedPortrait").toString();
			sql.append("AND C.COMPOSED_PORTRAIT = ? ");
			typeList.add(Types.VARCHAR);
			argsList.add(composedPortrait);
		}
		if(typeList.size()!=0&&argsList.size()!=0){
			int[] types = new int[typeList.size()];
			for(int i=0;i<typeList.size();i++){
				types[i] = (Integer)typeList.get(i);
			}
			Object[] args = argsList.toArray(new Object[argsList.size()]);
			return this.executeDataset(sql.toString(), types, args,true);
		}else{
			return this.executeDataset(sql.toString(),true);
		}
	}
	
	/**
	 * 新增优待金（非义务兵）发放对象
	 */
	public DataSet getNewCompulsoryGrantObject(ParameterSet pset){
		String peopleId = (String)pset.getParameter("peopleId");
		String registerId = (String)pset.getParameter("registerId");
		String objectType = (String)pset.getParameter("objectType");
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT SYS_GUID() AS REG_DETAIL_ID,\n"); 
		sql.append("               ? AS REGISTER_ID,\n"); 
		sql.append("               ? AS PEOPLE_ID,\n"); 
		sql.append("               P.DOMICILE_CODE,\n"); 
		sql.append("               C.NAME AS DOMICILE_NAME,\n"); 
		sql.append("               CASE\n"); 
		sql.append("                 WHEN ? = ? THEN T.DISABILITY_TYPE_CODE \n"); 
		sql.append("                 WHEN ? = ? THEN T.DEPENDANT_TYPE_CODE \n"); 
		sql.append("                 WHEN ? = ? OR ? = ? THEN T.DEMOBILIZED_TYEP_CODE \n"); 
		sql.append("                 WHEN ? = ? OR ? = ? THEN T.WAR_TYPE_CODE \n"); 
		sql.append("               END OBJECT_TYPE_CODE ,\n"); 
		sql.append("            P.NAME,\n"); 
		sql.append("               P.ID_CARD,\n"); 
		sql.append("               T.ACCOUNT_CODE,\n"); 
		sql.append("               P.DOMICILE_TYPE,\n"); 
		sql.append("               T.OLD_LONELY_FLAG,\n"); 
		sql.append("               T.SUPPORT_PATTERN\n"); 
		sql.append("          FROM BASEINFO_PEOPLE        P,\n"); 
		sql.append("               BPT_COMPULSORY_SUMMARY S,\n"); 
		sql.append("               BPT_PEOPLE             T,\n"); 
		sql.append("               DIC_CITY               C\n"); 
		sql.append("         WHERE P.PEOPLE_ID = T.PEOPLE_ID\n"); 
		sql.append("           AND P.PEOPLE_ID = ?\n"); 
		sql.append("           AND T.PEOPLE_ID = ?\n"); 
		sql.append("           AND C.ID = P.DOMICILE_CODE\n"); 
		sql.append("           AND S.REGISTER_ID = ? ");
		
		DataSet ds  = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,
				Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR},
				new Object[]{registerId,peopleId,objectType,11,objectType,21,objectType,41,objectType,42,objectType,51,objectType,61,peopleId,peopleId,registerId}, true);
		Record rd = ds.getRecord(0);
		Record resultRecord = new Record();
		resultRecord.set("regDetailId",rd.get("REG_DETAIL_ID").toString());
		resultRecord.set("registerId",(String)rd.get("REGISTER_ID"));
		resultRecord.set("peopleId", (String)rd.get("PEOPLE_ID"));
		resultRecord.set("domicileCode",(String)rd.get("DOMICILE_CODE"));
		resultRecord.set("domicileName",(String)rd.get("DOMICILE_NAME"));
		resultRecord.set("objectTypeCode",(String)rd.get("OBJECT_TYPE_CODE"));
		resultRecord.set("name", (String)rd.get("NAME"));
		resultRecord.set("idCard", (String)rd.get("ID_CARD"));
		resultRecord.set("accountCode", (String)rd.get("ACCOUNT_CODE"));
		resultRecord.set("domicileType", (String)rd.get("DOMICILE_TYPE"));
		resultRecord.set("oldLonelyFlag", (String)rd.get("OLD_LONELY_FLAG"));
		resultRecord.set("supportPattern", (String)rd.get("SUPPORT_PATTERN"));
		DataSet resultDs = new DataSet(resultRecord);
		return resultDs;
	}
	
	/**
	 * 优待金修改数据集
	 */
	public DataSet queryCompulsoryUpdate(ParameterSet pset){
		String registerId = (String)pset.getParameter("registerId");
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT REG_DETAIL_ID, REGISTER_ID, GRANT_DATE, BELONG_YEAR, PEOPLE_ID,\n");
		sql.append("       DOMICILE_CODE, DOMICILE_NAME, NAME, ID_CARD, ACCOUNT_CODE,\n"); 
		sql.append("       DOMICILE_TYPE, OBJECT_TYPE_CODE, CREDENTIALS_NO,\n"); 
		sql.append("       DISABILITY_LEVEL_CODE, DISABILITY_CASE_CODE, DISABILITY_GENUS_CODE,\n"); 
		sql.append("       OLD_LONELY_FLAG, SUPPORT_PATTERN, GRANT_MON_STA, GRANT_MONTHS,\n"); 
		sql.append("       OTHER_SUBSIDY_ONE, OTHER_SUBSIDY_TWO, OTHER_SUBSIDY_THREE,\n"); 
		sql.append("       OTHER_SUBSIDY_FOUR, OTHER_SUBSIDY_FIVE, IN_TIBET_ADDITIONAL,\n"); 
		sql.append("       MERIT_ADDITIONAL, OTHER_ADDITIONAL, GRANT_MON_SUM, RECEIVE_NAME,\n"); 
		sql.append("       RECEIVE_CONTACT, GRANT_NUMBER, NOTE, REG_ID, REG_TIME, MOD_ID,\n"); 
		sql.append("       MOD_TIME, BELONG_DATE, OLD_LONELY_MON\n"); 
		sql.append("  FROM BPT_COMPULSORY_DETAILS T\n"); 
		sql.append(" WHERE T.REGISTER_ID = ?\n"); 
		sql.append(" ORDER BY T.DOMICILE_CODE, T.DOMICILE_TYPE, T.OBJECT_TYPE_CODE");
		
		DataSet ds=null;
		if(pset.containsKey("limit")){
			ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{registerId}, pset.getPageStart(), pset.getPageLimit(), true);
		}else{
			ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{registerId},  true);
		}
		DataSet resultDs = new DataSet();
		if(ds.getCount()>0){
			for(int i=0;i<ds.getCount();i++){
				Record rd = ds.getRecord(i);
				rd.set("regDetailId",(String)rd.get("REG_DETAIL_ID"));
				rd.set("registerId",(String)rd.get("REGISTER_ID"));
				rd.set("grantDate",(String)rd.get("GRANT_DATE"));
				rd.set("belongYear",(String)rd.get("BELONG_YEAR"));
				rd.set("peopleId",(String)rd.get("PEOPLE_ID"));
				rd.set("domicileCode",(String)rd.get("DOMICILE_CODE"));
				rd.set("domicileName",(String)rd.get("DOMICILE_NAME"));
				rd.set("name",(String)rd.get("NAME"));
				rd.set("idCard",(String)rd.get("ID_CARD"));
				rd.set("accountCode",(String)rd.get("ACCOUNT_CODE"));
				rd.set("domicileType",(String)rd.get("DOMICILE_TYPE"));
				rd.set("objectTypeCode",(String)rd.get("OBJECT_TYPE_CODE"));
				rd.set("credentialsNo",(String)rd.get("CREDENTIALS_NO"));
				rd.set("disabilityLevelCode",(String)rd.get("DISABILITY_LEVEL_CODE"));
				rd.set("disabilityCaseCode",(String)rd.get("DISABILITY_CASE_CODE"));
				rd.set("disabilityGenusCode",(String)rd.get("DISABILITY_GENUS_CODE"));
				rd.set("oldLonelyFlag",(String)rd.get("OLD_LONELY_FLAG"));
				rd.set("supportPattern",(String)rd.get("SUPPORT_PATTERN"));
				rd.set("grantMonSta",rd.get("GRANT_MON_STA")==null||rd.get("GRANT_MON_STA").equals("")?"":rd.get("GRANT_MON_STA").toString());
				rd.set("grantMonths",rd.get("GRANT_MONTHS")==null||rd.get("GRANT_MONTHS").equals("")?"":rd.get("GRANT_MONTHS").toString());
				rd.set("otherSubsidyOne",rd.get("OTHER_SUBSIDY_ONE")==null||rd.get("OTHER_SUBSIDY_ONE").equals("")?"":rd.get("OTHER_SUBSIDY_ONE").toString());
				rd.set("otherSubsidyTwo",rd.get("OTHER_SUBSIDY_TWO")==null||rd.get("OTHER_SUBSIDY_TWO").equals("")?"":rd.get("OTHER_SUBSIDY_TWO").toString());
				rd.set("otherSubsidyThree",rd.get("OTHER_SUBSIDY_THREE")==null||rd.get("OTHER_SUBSIDY_THREE").equals("")?"":rd.get("OTHER_SUBSIDY_THREE").toString());
				rd.set("otherSubsidyFour",rd.get("OTHER_SUBSIDY_FOUR")==null||rd.get("OTHER_SUBSIDY_FOUR").equals("")?"":rd.get("OTHER_SUBSIDY_FOUR").toString());
				rd.set("otherSubsidyFive",rd.get("OTHER_SUBSIDY_FIVE")==null||rd.get("OTHER_SUBSIDY_FIVE").equals("")?"":rd.get("OTHER_SUBSIDY_FIVE").toString());
				rd.set("inTibetAdditional",rd.get("IN_TIBET_ADDITIONAL")==null||rd.get("IN_TIBET_ADDITIONAL").equals("")?"":rd.get("IN_TIBET_ADDITIONAL").toString());
				rd.set("meritAdditional",rd.get("MERIT_ADDITIONAL")==null||rd.get("MERIT_ADDITIONAL").equals("")?"":rd.get("MERIT_ADDITIONAL").toString());
				rd.set("otherAdditional",rd.get("OTHER_ADDITIONAL")==null||rd.get("MERIT_ADDITIONAL").equals("")?"":rd.get("OTHER_ADDITIONAL").toString());
				rd.set("grantMonSum",rd.get("GRANT_MON_SUM")==null||rd.get("GRANT_MON_SUM").equals("")?"":rd.get("GRANT_MON_SUM").toString());
				rd.set("receiveName",(String)rd.get("RECEIVE_NAME"));
				rd.set("receiveContact",(String)rd.get("RECEIVE_CONTACT"));
				rd.set("grantNumber",(String)rd.get("GRANT_NUMBER"));
				rd.set("note",(String)rd.get("NOTE"));
				rd.set("belongDate",(String)rd.get("BELONG_DATE"));
				rd.set("oldLonelyMon",rd.get("OLD_LONELY_MON")==null||rd.get("OLD_LONELY_MON").equals("")?"":rd.get("OLD_LONELY_MON").toString());
				resultDs.addRecord(rd);
			}
			resultDs.setTotalCount(ds.getTotalCount());
		}
		return resultDs;
	}
	
	/**
	 * 查询导出数据
	 */
	public DataSet queryCompulExportData(ParameterSet pset){
		String registerId = (String)pset.get("registerId");
		StringBuffer sql = new StringBuffer();

		sql.append("SELECT REG_DETAIL_ID, REGISTER_ID, GRANT_DATE, BELONG_YEAR, PEOPLE_ID,\n");
		sql.append("       DOMICILE_CODE, DOMICILE_NAME, NAME, ID_CARD, ACCOUNT_CODE,\n"); 
		sql.append("       CASE DOMICILE_TYPE\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '农村'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '城镇'\n"); 
		sql.append("          ELSE\n"); 
		sql.append("           ''\n"); 
		sql.append("        END DOMICILE_TYPE,\n"); 
		sql.append("       CASE OBJECT_TYPE_CODE\n"); 
		sql.append("          WHEN '11' THEN\n"); 
		sql.append("           '残疾军人'\n"); 
		sql.append("          WHEN '12' THEN\n"); 
		sql.append("           '伤残国家机关工作人员'\n"); 
		sql.append("          WHEN '13' THEN\n"); 
		sql.append("           '伤残人民警察'\n"); 
		sql.append("          WHEN '14' THEN\n"); 
		sql.append("           '伤残民兵民工'\n"); 
		sql.append("          WHEN '15' THEN\n"); 
		sql.append("           '因战因公伤残人员'\n"); 
		sql.append("          WHEN '21' THEN\n"); 
		sql.append("           '烈士家属'\n"); 
		sql.append("          WHEN '22' THEN\n"); 
		sql.append("           '因公牺牲军人家属'\n"); 
		sql.append("          WHEN '23' THEN\n"); 
		sql.append("           '病故军人家属'\n"); 
		sql.append("          WHEN '41' THEN\n"); 
		sql.append("           '在乡复员军人'\n"); 
		sql.append("          WHEN '42' THEN\n"); 
		sql.append("           '带病回乡复员军人'\n"); 
		sql.append("          WHEN '51' THEN\n"); 
		sql.append("           '参战'\n"); 
		sql.append("          WHEN '61' THEN\n"); 
		sql.append("           '参试'\n"); 
		sql.append("          ELSE\n"); 
		sql.append("           ''\n"); 
		sql.append("        END OBJECT_TYPE_CODE, CREDENTIALS_NO,\n"); 
		sql.append("       CASE DISABILITY_LEVEL_CODE\n"); 
		sql.append("          WHEN '01' THEN\n"); 
		sql.append("           '一级'\n"); 
		sql.append("          WHEN '02' THEN\n"); 
		sql.append("           '二级'\n"); 
		sql.append("          WHEN '03' THEN\n"); 
		sql.append("           '三级'\n"); 
		sql.append("          WHEN '04' THEN\n"); 
		sql.append("           '四级'\n"); 
		sql.append("          WHEN '05' THEN\n"); 
		sql.append("           '五级'\n"); 
		sql.append("          WHEN '06' THEN\n"); 
		sql.append("           '六级'\n"); 
		sql.append("          WHEN '07' THEN\n"); 
		sql.append("           '七级'\n"); 
		sql.append("          WHEN '08' THEN\n"); 
		sql.append("           '八级'\n"); 
		sql.append("          WHEN '09' THEN\n"); 
		sql.append("           '九级'\n"); 
		sql.append("          WHEN '10' THEN\n"); 
		sql.append("           '十级'\n"); 
		sql.append("          ELSE\n"); 
		sql.append("           ''\n"); 
		sql.append("        END DISABILITY_LEVEL_CODE,\n"); 
		sql.append("       CASE DISABILITY_CASE_CODE\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '因战'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '因公'\n"); 
		sql.append("          WHEN '3' THEN\n"); 
		sql.append("           '因病'\n"); 
		sql.append("          ELSE\n"); 
		sql.append("           ''\n"); 
		sql.append("        END DISABILITY_CASE_CODE,\n"); 
		sql.append("       CASE DISABILITY_GENUS_CODE\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '在乡'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '在职'\n"); 
		sql.append("          ELSE\n"); 
		sql.append("           ''\n"); 
		sql.append("        END DISABILITY_GENUS_CODE,\n"); 
		sql.append("       CASE OLD_LONELY_FLAG\n"); 
		sql.append("          WHEN '0' THEN\n"); 
		sql.append("           '否'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '是'\n"); 
		sql.append("          ELSE\n"); 
		sql.append("           ''\n"); 
		sql.append("        END OLD_LONELY_FLAG,\n"); 
		sql.append("       CASE SUPPORT_PATTERN\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '分散供养'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '优抚医院'\n"); 
		sql.append("          WHEN '3' THEN\n"); 
		sql.append("           '精神病院'\n"); 
		sql.append("          WHEN '4' THEN\n"); 
		sql.append("           '光荣院'\n"); 
		sql.append("          WHEN '5' THEN\n"); 
		sql.append("           '敬老院'\n"); 
		sql.append("          WHEN '6' THEN\n"); 
		sql.append("           '其他'\n"); 
		sql.append("          ELSE\n"); 
		sql.append("           ''\n"); 
		sql.append("        END SUPPORT_PATTERN, GRANT_MON_STA, GRANT_MONTHS, OTHER_SUBSIDY_ONE,\n"); 
		sql.append("       OTHER_SUBSIDY_TWO, OTHER_SUBSIDY_THREE, OTHER_SUBSIDY_FOUR,\n"); 
		sql.append("       OTHER_SUBSIDY_FIVE, IN_TIBET_ADDITIONAL, MERIT_ADDITIONAL,\n"); 
		sql.append("       OTHER_ADDITIONAL, GRANT_MON_SUM, RECEIVE_NAME, RECEIVE_CONTACT,\n"); 
		sql.append("       GRANT_NUMBER, NOTE, REG_ID, REG_TIME, MOD_ID, MOD_TIME,\n"); 
		sql.append("       CASE BELONG_DATE\n"); 
		sql.append("          WHEN '1' THEN\n"); 
		sql.append("           '抗日战争'\n"); 
		sql.append("          WHEN '2' THEN\n"); 
		sql.append("           '解放战争'\n"); 
		sql.append("          WHEN '3' THEN\n"); 
		sql.append("           '建国后'\n"); 
		sql.append("          ELSE\n"); 
		sql.append("           ''\n"); 
		sql.append("        END BELONG_DATE, OLD_LONELY_MON\n"); 
		sql.append("  FROM BPT_COMPULSORY_DETAILS T\n"); 
		sql.append(" WHERE T.REGISTER_ID = ?");

		DataSet ds = this.executeDataset(sql.toString(), new int[]{Types.VARCHAR}, new Object[]{registerId}, true);
		return ds;
	}
}
