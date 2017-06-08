ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1.sh | bash"
  exit 1
fi
(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f || echo 'All removed'

# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh

# Start all Docker containers.
docker-compose -p composer -f docker-compose-playground.yml up -d

# Wait for playground to start
sleep 5

# Kill and remove any running Docker containers.
##docker-compose -p composer kill
##docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
##docker ps -aq | xargs docker rm -f

# Open the playground in a web browser.
case "$(uname)" in
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
� {Y9Y �][s���g~�u^��'�~���:�MQAAD�ԩw� �����&�\&��Iسk��&(�Bӫ{}k���nr�7ѕ��i� 9h�,�(M"�w���(Ja$����1�R#?�9��M7vR�}�$�n��\��(�G�}?�&�����4Z�2".�?ED%�2��oϠ�2.�?�8Rɿ�Y�ŋw���叒Uɿ\(�������u4\.��9�%���C�����p��ɢz%�p_���D��3]�?����ܠ����c��GcAQ������w�O�h�z���C�1�Fhsp�<��)�r	�i�)�!	�\�(!�i�d0�v<�tQ�	�&���W��(C���O/��D�<���������*��Y������.��km�:�AJ��&���D�tR_�L�`�Q�k�NC٤��MfBj��|�����F_!Xdb3h�q<u���&������D	�.{�B47i����',=�NvR7��@��4}������H�e�����%�^|��}��+��K��ww�o�_������\?���1����0�Z�+%������u�/����8�T�H��K��ϋ�!K2���[�/�|��y�vC��eMYI|<�{;f��w-�e�6���|��i� f\�hi�%�����98������甶�I�=��%[�8T8�T��u�I[Y kH��:s��� ���"�s�����(�E��P59�|�[�G���t�
G� �qEP2�8-D1��`��9����e� v0?�`����#С�C�����X:xkkŽ4�s�kf^6��R�Z��ha�}� D��������E�I6�o��+���g��x�P��&�P�ȀS}U\J����v}1ߏ$2!�F�4���5Vl�Z�:�����6��Y�J.�\���+�4���Q��Δn�Z�lt�<��{B&rp����������{^ .ԋ��V�x�,)@�@�d�B�:��xY���"e��M�����5 ��zdm:�������}�\+L�\�<@B��^�x�:t|$W1>��-�
F\Ę�R�h����!=�[�߷39�V��%���D�|�ՇLC�"9�cш�̢M�Q��>,>0����{f��_���4|������������Om�W�}��J������_����,��_j�a�l���zov��yƇ�܎��q��q"T�G�z	�B?bԷ*�!)C��Ȁ
�
���˹��{N��=��,,LCѕ�&�,f�`��x���b��V&�SYS�P���jM������+���B�7�,�.i���ռ���ž�@h]�.?���gN�Ȅ�D�=�5a�f[8�����)gFN���E {���@��N�q������xH�8�t�=܇�.���|K3ymJ
�(�Hs=4���Lrآ��Fޥ>��6s4!��7�8��D���͛X�����P���o�m��D����0��Z<��h�Y�!���&��x��_�������?$Y�����Ϝ�/����������G��W�������/��7�^���GHW�_~I���S�������~}��>E8�b�P6�� �H6��0M���H@�.���Ca��(�jg=ҫ��.�!�W����PY�e������qG��V�4��U��,���h]�o����b��F6v`׶�17�ij���Vު���v��[_r̹�4p�Nv#:�967�hk����7�V��(F��v%�Ӱ��y/~i�f�O�_
>J���U��T���_��W���K�f�O������������T�_)x[�����{3�B��
Sz��М���?�}0�ߕCE����f����lh ���N����p\�� ��I��!&��{SinM�	���0w�w�%��5I���Ng���nYo&�w��2�#Д(��8��+nP�dݎ�"<tO��1m��r6("�
�^p ;G�dqڠY	�Th��� 9����4�+vz��	'�6o>C횬LBGDy�Z|g����haڳ'�&Te p��`����^��Y_�b��n�in��:+{��,�;�!/7;���(!�X\J�H�,E��vC2�	\��x�Ѓ�������%����?x��e�C���?�����������s�7��~w
���EЊ�K�%���_���_����T�_���.���(��@r*�U�_	���=�&<w�Q��Ѐ�	�`h׷4�0�u=7pqaX%a	�gQ�%Iʮ��~?�!���������J��*vE~�^������֘.�m���H�n���ñ'/H���?�@�N�E�:�$�А��r7��U6^�0�m�.3��)mw7p{G��=1�K�4x6����MF��sJɨ�~V������x~��)�/��Q����������;���c���������2�p��q���)x����}��r�\�4�c����G������?MW�K���������t��S>e��4B��?��9�m�.cS,���x.����a�G#�n�8K0A��6˰>Z-��2������������?]D�Ǉ �D4�^�����nc�0�>���� M��6/���4�«v]wל���s	�'�aDn�l̄�]痩�\�G-ptˇ`�Od��4���S멈k���6�1{0��j��������v�w�U���w��P�xj�QE�����||��P|i�P�2Q��_��P�|�M�>ae������E������9k9
�V�% �<4�g��ǳ���,	���c�y�T�ebxT�ٹK}�.�t���y�֣<��]"��恆4���i疉��O}�J'�y�Hw�m�=b��7��j�6�a�ŰE�\�n&i}�G"<c8x&�8�d6ub�ysD������w⢹���lЌU0�9����#=�mE(����1��&1`[���&�0�BK,^���ԕs]#?�5a��7�STY�M9�S�+w*�vg<6� j-�y��<�K�I�z[.͒-�}�?�� �'�)gSs���u��
m-mt��J�4�U�S����Ӷ7���@��p�Df�	zR&�do��l�ޯ�u].��x�4������������q���K�oa���^e��=��������-Q��_�����$P���^
޶����c�v�l�n�%��T�w|��c���?�e~��P~�(�|�n#�[�������<�Z�� 컦�Oܖ���I>�AB���M�u7!�C$�PI����H{�.�}�VzjB��=�[3�c7҄�!�JgL�:M���Tfx@A7��W㸯ƍ��A@OB�=��܇.���� ��Y6h��@]��v#x6�қnҷ��`�6��\��^Jfr��{���,�C�7z}��{���46a�D��h�"��������_Jq����d�W
~��|�Q��)	�1����ʐ�{���������G��_��W����������\l�cV��s9�\��[w�?F��B��e�����+��s���X�����?�ￕ�������1%Q�q(�%\���"��� p���G	�X�
p�G(�����*�o�2�������/$]������ �eJ�-sjF����S�m�]+],�F��-j���c���Q[iXW��=E����ġ��᎕QRs̡��+8��	L�[:Yg�Q�&'��F}���ش�f����ܹ���G�}X.>�?��(�ԓ�/������I�k������ (�����ӯP���Hq�զK;���&��O���1��d�^���=C�P�z�\#W�"�ا����4�VK�9_�V��I��e��7ͮ"~�����WE;����8J6��k��FH�k��_�s��]�+�k-�Ԯ��_O�Q+Ļ�]�g��Պ`��k���I>������e����y�+�v�`���7���]y�.�E����G��%Yݾ��)n�{���+?�Y��|T����Š�­�p;r�V�+}eX�V�hluuA�E��!��:7�o�*]���!ק/�.�}���F�+|+d�ZUI��`�;j��7Y%az}�(��"׳/7�˃����·����Wk����4�3�^������}�u��Y�E���5o�4'��w�,���b�w1C~z�N��/v7�~z5��5x���ߟ_ʾ���~>c������6����NM͢d>]�7�4�Z��x�Qlo&p��p8�L��u��~0�I�^�=<�D�:)!�#%pVϧ�� }T�#�~~ˇ#2�����NE�膢�E��������w�F���Y��[X ������I���Ӧ���וU��v5��ax�xg'p�]�gK�:}8�O����ͧ���{\�_�����޵�8n�g��e|6��4Ҭ'�Ck׻��g$���7똺k$J���ݮ)��(Q������
�@/H��oҢ	�`4ڧ6hZ�}i��64i�"(��A��iϡ(�����x���<�P��������?�hC���\��@�*1�D�/FB{T&<P9�s���td�v"�((m��1�aOB$'�2��S1�鎌��&i ݞ�H@��h2.��#"� �dlr��p�	z"�p���I�.\�TU��TgkPX��
��K�I��a� 悋��`g�D�#����-�&�Fe[gI8��o�#��3��O�����D:3�!(�\"�����S�o��
��S��$ΡJ�"j�����l�Yi-4��HHL��A�7�"l4���I!>=|�x��|�D4Ze�ŉe�6�Ѝ�Z����b4%>�h:C>�h����8	�.�d©	�'�S��z>pj?��^�4�5��E��u�uĎ�o��_���X���W=6��U���N����g��-+��/bt��^��_�_3����XK�cQK���+�W'( MM�����|H��4E�SX�o�,a�������h6�
	��;��gSYFH�����&g�u�Va� ɖv@ټB���cx5�k m�"^�Hn�h�f49�_oN}�n�xmY@Ů�-aFA�;˜8w��ݚ)rؓZ����������c�,�h�q��5���&��VZ�ڜ��bcu?�!��bD�:��D#�׼�V/q�r��5ݏ`�׉XX�+ìx��ɧf<D�ӭ����ç{m�6Ç&��ƪ3\
Z��kw�ɩ���m���KX��s�ԟS�.�v��`�#��c*;S�ʎ���sz�tLB�S9Yd�0M�1��א�R��e��/���}?�a��N7������%���c��)A��V�ک���߱���A8��'��Ώlva3�9�p�k��%F���5	��%�/��.��pU�e�)u8����!;��U_%��6��6Wp���/�uK�Zx_�y����[��:^��
&�p�e��Ɛ
�Q�o1��x������ķ*��o���S��1�^�2L�_4�_7ҌK0I�ǫ�;NaXP�D���g��?�[�<���A��b�'���_$I8m�.X��t��?�K�Ej�,�[.���e�_������x�t�v:���n�nݵ�/[�+W�V�����)k#�})E�0G��؏���0`u�w;�)��L������=�����K0���s�FV�r�L�I�6��N��p���Ϲ���p	mL8A"���j��?�A@.K2W�{(L�&lp��D�Ӈ9����r#Ӎ�2v$Xy�������|�9���a�����D�	��=m�#�������u8Aj!�\�>>�Z�+���´e� Ȓ �dp	�LIs�f۲�R�����$��I5�L8�����"{�o@l��h6��"E�-������;c�w��"��&�5�/��wg�t$����o]GE��\0I��
�N}g��D=0 }y���n���|��	SD+)W/O~�����ʛ�P��m}W��RO��+;��_R8�Ye��*LľA8�u@K"2w��/ܴm��ڼ�y����߼�_���/�e�u�R���*�T���v�����+��ڊ��/�6YR��� Л��u���b�L�$�Lr�������T{�>�����p�0���#,��N����Q���������M��s	����,
/��p9�is��_�����&�?.�4
K"�eE�9Y��W��C�e�f�6@#��9Z�3�O�	��ӵ6LS�������5Fś|���%�P���*�6��ԕ�my������XgG|������i��ɿ[?��C;�������G�P��Tb�׆��p��j����w4C3���m0rC�W��$�����Eb9�s�xG��,G���ʥy1��q��4��������=��y�������/��mJ���WT��#lP�=���<� ,���Q�P!u�X�$�A�D)p	y�����mc��f�����h([Cj�xb��ʡ ��Qy�.�
#��r|����K�p9��K���6��{.ᣯ�������0n���\�5�2�a��ETix�$�Eͧ]�R��5NMK4uF6Z�(�J�;�F�E��QNC��kCK�|��]��Z��Χ-�;n�cu����Т��_����-	�ؼ�N�4�ߡf]|@�A���Piv%^���X�����bn�3�[��a���j�F�$f�&&Ӯh	Y͉�KO��鷷����\��o��	�X��G"��&m���<���?.���C����v�p���p����;�n���\�a����6]���~�/�<n���KD�b[e��a��a���tW�n��)9��a����RA�{��L8X7�:X�������]��ϫ�?��_�����Vҿ�Н����߸���
��(x'
3��F�xL?�c��/ px..��6��y�)������>�}������K��l��R��R�.��Y���(X����5����y�n����ۥ�.�it��o�]u�]�ʍ�O���-@~o���!ox`>U�磳�)[��F=�,�N�������Kl��%�=/�k��f����A��u�B�n)5H�95��у���ox\)���:����� Kz��l�;�g9�x��d��
����Lj��$��B ��2�v� �l��*�k��)\/Egh�GK$�Mh/C����z� �Z![����H���W��T��k��{��-
E_�d��j�Q�֤2�*b5RM8��T�ո�[�jV�a�~n���{-k���Q�o�
G]�}�Q�&,�&,�&��܄�}{)�a�G"l`Hєg��6�������+Þ�m�j]P̭���?k��N�L�NyA�Y�l��N:!�T�N���c�������I&��~6HVU���Vi���`-f�@6.������䠝L��5)Z� �WCi�#:��uY��'hu`3�J�C��`�����)?a��J�,�|�R��c��{�j2^qR|��t��b��F�s:l%Ռ{�t)����N'){��r{����e��1K�̲kOo�w��j�X��X9*�A�m�7Xk*�T�l��#��$+�Yo�7(1��+��O~O�5��\,Z�1e���[�
h���1�謒�!:�۫�(MӮd�J����LO�.d�����|�L�A���"��c��}���ڡ��qbM�F������ �"{�]�+G!�M�7��l7WI�]�x��VZ>�zo�%2�Yzs��w4�ԏ�,a2��Q��-�Y2��P�Gk}���j{�4�K9���n�8N�rų#�V8/���A�Xab������ �@��Wc�@-��~�r��NQ	g(�gK��l��a�)�	څ̒�oZ�����22ߣ��j����ͻ����U������'��]In�!�._��4eV�	Y�#Wwj�L��CD?nw$��F�(f��:����:��t��G)t�b!�c9�W9Y�^_{��ְG�����x���Tڈ� �v�!����cO��Yp<���������^Fek��9��bOc��G�N[S1H^Oj�ktn�$�l{{<E�,�R)A���x�7�)�8E�ym�M��Ʋz��p��V2���c���I�x\+M�p�g�k`����K\|�-ܨ��h��ؓk������C�5�v������c�Ş�ď�1���l��b�fԋ����{\�Z-��߹�� C���;�{�	D�&���l�` �h6����G���������C���ֱ��c��~��9)0'Ǟ��t����M���$-}�z���伾����:v3�(��l�[��J���](����f�8�祣I{ParE8�9[�L G{��a�G����v$P�B�Yg��zi�}5�`G8����4�{c8�:���	����,	�
6:+���|�ö�2h 6O� �h�ƨT@�4Ƌ5&�n��l�&"��M�Yۃ����N���Z�#�t��N ��U���'ƈ�������	��j�[��	��,���m�N'����2M94V��့U���6�a������Bϔ�#�	Ҕ6dw�#��E�8/(�ھ��K����.�:����H;�	�R\6{p�)��1wk�[dM�����6֖��� ����ʀl�p�h7R��5y7%�,AB���y����Yd���K���"��Hᰘ�a
�)K�Xۡ��"�9�T~vL����!]1�1ҙ��04���s��ٱO`��:�Hò/հ��?}m�L���kGkX�sѰLK�'ǒv�A$=fa�@9A��&�����=3�P�l�#���*��r����"ԄQdd'5��J�F��b�IVo|<�hƐi[�4�$�f+���b5�+����E��=��E���ڤջWˆ����
b�V'hm����Ѧ$�3��=Wؚ*�	D4R�s�Ɛi[X�rh��:��d:�S�L�ɩa�km�Ѩc��⹎J�\�G֧4����v�ŚjU]�l����T����� d�f�q"�˄��$D����_��
�u��M&�)�za?�iw����U�L4,S8L�߄c%��>i�;�Rf_Y)��q�ױLr�0�ml�g5���Q�0��x��V�6��e�Z��0<5F��[4�rY��S`�=��p5ȯ�u=QJ�J�
�&�ak��t��;]gm<V��8cGEE���0�����nó�G_��v��?�����y�[o����޿���/b�+|Ud��:|���nf�+�ν���<����)�Oa��y>X6��|����y�'��o	{���g^��g���o�zꏂ~�a�b�[1�{1�Ϯ=��~�o4_�hוv�(_�6��?���_���/7�A���������[?�M��Q�~��(�/c��߷`L�v��t�4];M�N�M�t0];�U܏�*�i�6Ҧk���i�v�:���}\;W��<G�k+8U��.���a�4�49��<��Q�3p=3{�;�����)�Ͽ���?��.f��j��g`.��K����)�p�3?��H��k�<�����m6�4-sόim5�̘��m�S8L�8�=3'��{�-0�3��Y�����+mNɲ�qZ��qMDE4ek��&FH���pheG 	T�����b0x��,��y^<�RJ���{s9y���G�m~��џ���g�/=d�@��H<�^�y���no��D��$�習8E���Q (�5�O���
AAh�s�R��܇G��k��T����r`[��@���y��{Qk�{�Wd�Ǚ8�᩻���a;�ϸ�I����	�v���)��2���[1�ԭr�Wt��e�_�u�թ���0�zn�[�f�d������9:��*�)�2jR�����:������"K�$�"��"&B,J�$I)O�(P�V~�μ_1� ��x11������̵^|e:؄�A��{����[��{w �S��~�ג��Â�#}������T�7�?y�nU�X�O9�,ֹ�SIj4�2'u����܅�^��nHYl�+�lߋ��Jj�A���*��_��s%߼������$���`���]��>�Yj<�y�)��wUK߈Y�Kmߔ,����ܱ�O�E�B�|֑i������ͧ�+�&�5~���G)����y�bx��*6v���z�=���'}`ߧ`k��=k��}ر5�益58�Bs;)���`��M�K$���󦽯�'�N�b��)a<���'����$�k��l�͗�!��7�v~ӫ��W����2_�'�#򭦸?R�,�Ӹe�������ip[�یP�H���t���a�o9.�Tl�^Lw�ѝs���;��_o�����N/�����m�<O<�w��;t!��W�Y)W�����|��\�ѐ�O�z�$r~k{�=���-I���?��K�^�J��{�׉�4��EO�	8h�/���ހ�޸��xN�)�'<s��!��GB��xly�������4qR���ҍ�Ӎ���G��0O���Jjj�ͤ'���!N�ug�_7������d@8;{���'��o���4��:䷅�C�^����c�<醩,���S�Řy��ׂ��]RaՈs&DO�����q��ޟ6�?O�o[�=G�g0�_q�4tcfLu�ɷ�_�`E��}�M���lz�C˦��1�����Wot
��stJ��)�W�S�O��>`k��=0��;-�������!1���d��7�i\]�xp$(�(����@��i\_�(�����ו��{Ҹ��q�
��w��?%k�+��ȸ|G�aY����$}R��o����	��o[��V����E�����<����D��	���M��Q �O#���������X;�e�#H
 �����1?�����i��0�L�u�R(�PP��Q�bU�Pp]c�2R5P��H�U�HE�0������Q����'�s�����hה�.�[�*���ީ��s5Q�$�Z9���M�\�_w�y��k沆�vaL��0ӣ�%~����(��c�jB�ǉ��;k.l����㨍�m�T�ȻN��ۣ5n��à��"�foՒ�����]��xC�%�ʌ��D�R��e�ڏ��/�|��3:�HB����y����?
D���K׃��	����w�����3���i��Q 6�?�ZwN|O$��C	;��Q �f ���qI5#��`��4z��c������1p��O������$�?�^X�	�#A\�� bC"���O�?
�����y���Y����ɞ�/����j�.	Ī������p���'�J?[�|{ھ��Z��ե��y����2��j���v�-���.9[�M�+停�<����@V<����`"p�����ȝ��Zٌ�_�c���9�+n�ˇ��I�Ê���#$S��Y�Wp�hx�[�Z��H��̲d��zYi���yuN���$�g���ٴ!��]�њ��,�"eo����K48��r����E��g�̀���R�6<�h��7 �fn����K$��C����������d�����K�c����& �G�x�L�'�����l ��`�����$�@�#>Di����O������D�?�����?��H �������G|���I��M�D1B7)���&N���_e�RLa��5�X��(��P�D�����?~0��?b��|�*�֏�Z�,x�N�Յ��)�]��i�8.��`���G�ͫ���\r�b��ǜ4˷k����� ?�g�d3_Y�=2�ޤ�e���6j����s���&fR�b�SI���g����ćh����4 ��{��I���b��(H��������������쿯����G� ���m�%����G|���O��@lH���?b���?��:T)|"��0�:t5��¿����d�
^K�<�V+x���=4�f���2M�<g���xe��H���3맫��;�m�ox�F+���j�2'���P�=U�.�>���R�4[Ӱ�|�B k?��pZ�s�֟-,�g�*�[_c�]<���$��>�p�V���f�L��.	\x���<N���؀,n���L�=��g��3�2�J$��`A�ƙV�/��c����J�+K���r���x�����C;=Y��q��ZK�T�2�U�4U�r�[�tZ�/�K��-�b)��I��H���՝b��e�O�2����*̿���I����G|����I���������!���IA"�0���?�����w<���_S�n���?�����@������3?��?a�S��( �`������I��0���_�Q�K��QH�U5)�P	���DM�YM�LG�%PaFe!�Y�����刢�߱�.�A��� W���^E���yY�����Rc*�p�<�jv^��Mm��JcRxU�%����R��mꡙ�:�e�R��㼃�������5�rQ[��jK�JU@ڛ	��x�l�=���m�7�d�Z��@������߲u�~I/Ӹ~��q0�	�������ח?��	�?
$��G��?@�5|u��}K��(��z�'�`����G"��������>��  ����������D�X�; �����q�l��F�d�?K#4�0,F�,���Bj�B��a�k�b���:���i&n�,���j(,�(�(�,�����}���"���n<�M�+���̋3j�J��=�k�eҖ\q�<jx���Mh𴘮k���벑�Ѻ-�%F̌&���Q�����iS3�z׀`İ%���V��,��	e�n�Z3Li�:���4���c���/��?E�X�pD� �������8	�cBR���2�-!����r����@�!�����������:W�s�2+]�4Y�+p��:'m��Gi3D��C��P,A�vT]��
:QT��6���1v��k��7U�<���T�.�I}�M�kh���3��*o��,��o+Y�[�aky���\w�o��6�n����\�=q��M���}X�'�Z���r��e��Z^��f���է��:)�4����^�x�j�7[rF
�[�%?/F�W�om5"��E"���\�,ow��֥󶓞���<�f8�g�~��m�|�b��S�PKx)��S��[�Y�,Վ��҆���w,��:ͭF$t,�)����P$��ez]1��	��n������CjyX�G9(�U֫2|�ܘj�l])=>6%�*��Q��ߘ�Ζ:$��.2�g/�ʑ>$���sBF��Ѽ�J��_Sha����"��xu��0W�Ơ��,N�k΄򛇕l��Y�zY�����bЫiw��?����X�e[�o?X"�?��b���q������K�?_��H�_�
��@"��3�������c�/����c�ð�����ʶKy�le6g�/����rp�����|46 ��@{!����<�Ё�>3lq<j�Nٿ��b���5�8::b�\�7i�&�k+�D���-�9��,�Z��U�j�&��
1��r�u�}��3df���U��:'�n��4���Fy�{�<��?b��C�����>�@ݡ��wT�<�W�^�݊�P�rk��f�Q����I�_-��ЕJ�ܭ�|�
��R.��QY#��,���B羟����������H����������_"�����E�D�?��������l ��`��������������D	`�G�$��(}����D��?���(��z��h`�G`�������O�������A�O�B���(Ũ�CF��A����8��n��J��A��a ��a��`88�+E��c�]:�!�������B�����"�6�B{ж�v�!0D�=е"�,8㱗�&�q�꿪��lMF�U��&V��ʊ��3��T	�3�uQ_���oDe�4��U�A~��W�:��	4C5k���L�Ӑ�(����?>���P\�߱@ն��ظs�I#�{���r��I!-0� �A����'����8}�%%�nʚ�́��)ö-����Lݔ2��^`�Lu�r7uk,!Ȟ�nm3���ݾ�����}��l[Q���G���v;2ַ[��o+YJI��z~Tj�(h2�v�v��$!MqS��gJ�dS����|�r7t�)�;��q�g��}�&�t��6p?��_�W������ߤ��={�����Ҕq�r�{!���a�)�c]w�2*�O&8U�$���Oaۘ/�m�K7�$���-�Ҙ�u~s���o�O��6]�(ݓ|�kK[7����_��+��ǋ���1����8"N��?v�&�L�+��"7��pݘ����2p��I�� ������Q�"��W-���V�&��{l�=���r_oS}�I��1��r=eZv���㻲!�����L}j�j��W�]��۩�Z����?8J"�������(pU�o���4>\�$�дo'`��>����'����]���x��#�߾�	����w��7�߁�N׳�߯�A��5���A��꡻;�~3U������l1�\WŎ�����qY!�IlWF�v��LWW�g�u\�����c�{�^-�����]]�S�~9#��HA⡀���"A�/���@> ���d!������������L6k�V���:��s�=��s�=u�q�
r�lsv����wz �cb�nx�y��
��g�� ��V�Y���jU��*��	�>�N>纂���K�T������y���n[�Ņ|/�7յ�7��}�����On^7���k��	�}���=j�"~o�z=���b�{����ZЊ�M�G	�G{iP�Ǡ�\�Go~F~��g��?�_y�U�������/���_��G��F�I#��n|5���&�T^3@�n�?xA���~�ﾼ�G/!��＄��K�W_�y��O\�����Yd�E�x��^X��w-ks���6�h�s�(١s�2=�vS�l�7�����g��g]�j]�D���*`t���3��C�! l�� �~�w�oG��I�ꞎ2ٮ��ȸ�x�`5!�7��]��*�>���^(P�ǕV�x�tc�x�6�xC�n�6�i�ʒGp/B@3���G�x�B���12�����(��PGb��l9�N�O�
G�0E��`�sN{����R�<J��Z��qGu�-WF�v�wT�MdZ?h��T;޸��s���(
i��D�=�?-���=���(.����~㚽n���+᫬��߸��6��¦ϵ��i��%C��Mщ����%�+�ʘ��7Q�3B���X��V��#4�&�제�a$�o��L~���rd�Q��K�l{a�a%�m�A�7jg%\��N)/�<�J��#D!r9�/L�B�(�����\TN���cr��e����+�`YI%���'���~����o}I7jl��Iă�D�
���dc$2(E���ƌo:�[�~.��6r�jD�r�R��t��`���}��{H�R^AX�=����$ގ׏2�cZL�t��z4^,T�m��E��`�擱JX�L����J,T;�;�t��Iw�T�$҇�������	Y��ƥ�X������l�P!K<w� ,s�3�g
KR���@m�-��4dRY�J	{�R(���DR(�b�~�C��L��ڡ�89����DXL�l�8��Q���R�Θn"d����2a/�����]AX��Ԉ)�	r�IW��'H!�\�3!���'�V�R��Q����0<Y�J�=1F�5a��P�M������^O�Hq=or��	K��g��$A���^]@��D��],��� ,s�3�g
K!�����3ڧDv�m�m<;����Z��E�H��_�y����H���q�q �K}��#\%�v}�N���P�1�y|���+�',���f�l�϶�϶q���mK�^䩪�ʌ(�N�����t��>����g�OX��f!�ߡ�Q�~�Rf}�Zf�1kUE�j^����"�S2݁�l�"�ϡO!Oz��d���<�kh��KO����gI�f2�q�Í���#ZL��H�Ȫ+��f���x��"�']G�!OH'� ��u��;e�O�7֐����q�0���&sn�Ϭ}E��돛0��gÜ@�*�6U��O�O��fwX�l3a�V��~�r� /�
߹�~��5�~�   Ow� ./���MA��AQ�����=��+A�!_|N���x��:�o���I�=)XyR���C���X��x,��#�n�9UÑ�
��������c�8F:YS�c��6h���%Ü9��}5d�ǎ�63��T!��a%ˢ�QgtѼ�Q����}�tW��m�7�����JB	��z{�Dm_�����!�Q"�����^���s���FD�8_8�x+���w�y�>
tk�p3K�TQ�j� �@x�%m31��(�����{�P�x�T��Q�P�H*�ʱ�ÈIz��Rrzj��|n���x��R
�x��T*��"�H3L����H*�#x�M��ݮ�Vz���D�z�=f���a�#��ӄX!�@궫!i��8q���B/�%V���)?W96m尕�V��X����
�i�T~��\ހ���XK>ӊ%ӳs�/�,�Fo�N}^���\�ay���q�]��W���<��ò#i�w"i�"%Kp��Śy��#E:_HvC~jZ h�np�t���ʓ3�r�d�Ճ"�LPĈ� W�T!ZP�J�E����0�t{Wd6R��\�s08�t��07	'�$ё$Z��{D!v<P�x��SI���P���8ދJi�O!a8�M&�@/pD:Վ%��`�|,�l0�4�)�t��`��>#'}�4�x�i�!�t�C��2����]��G�zG�$ځte��sM2��j}�p��B�H��� ^ �H��/TǍcOl�vr����6g�z��01T�y��v���s�v]�ò��V��o�q)��3�[�)�\�)�)�B�k���
a��]�5l�d*II�o�dQ�eET��k��g-��zD�l6EF�	p�Y�i=�ҭ�N�ැu)ɵЄNE�5�Z)Iz���\�+�,�Q!I�?�@G?f��������/����w^|��~���������_z�_���Ϣ����ʪ��;�;f�+��#AےKjWj�yu\�����x|v��#�������?������׿�>w����������~���?���{���w2Hya�1h���J��S����l�@o�0��}��;_���ɟ������|���3_C�F�O���F�ɒ���M�����۩�vj���i�	�ivj����Q_ŵ�v@�N��S;��N�g�}��Bj��-a>��K$U��DnF`�a64G�	����P��CH}h�և�j�����Ͽ���oIMx��l���3��R��T;��V[9>�<�+�H^!k�Q$3������l���of�h��͌�Y��Y��͌��r<�of���>�y_��~�a�K��VM���&�>�d·�_j2h���Ͼ>���?���[�vWH�<?�� �b~��`�g�>���`��K3��41�Z��JO(����` ��ˍ9!���js�.D1�OM0^�1Eb V�ԍ�14A˫�:p,����֣cqAG:�!S �1 �ZV@��(����F.J%�%�m���$<���r��. X/p�s��bp�_V�mL0J["i 29j�	"F�E��H�X8`�w0Ih�#Jd �&��<�/�<�j+ ��c�d	K�6�0YJ�v �j�����*Y,��r*V��E,��ES�T>~�12w��S��� n�z�� �Lr�i�l+1�	��Ҁ��K���m�j3X[ ΃aF��Q	؄h8����N����]���9�"ǀΖY�gp�逿@&�z���6޵$뛖�Ӡn�}��ay�?�0j�N��)��,����
 !ҙP@P�
l�Q�E痀���}~H/���yӇs�s�#+�]+Qp�y�Hj-��qZ���ۜy�P��Oz�D=<���¶1�ܑFO�6@;��x�w��n�hԵ9�>q:�ÁI2 ��2�9Ȭ�ᇮ�Q�+����cK��p���9�s�-�֢8����n�Ǐ �]T�Qw��#ㄒ傤8< �{��`���f���Q�wlAk.(iǸ@���JP% ���` >U	��W`�N0ФS���Y<��K�l�{�IZ1Q��� �khJ��`�ew��۪�S����ڀ�>�&�ON�i���sH����Q v�9�oT�o)���O_:w��[K��,�L�#Bq�fm ��A,�a��H�3l6�6"�q�я⛘��D�e`�1�k	U�U�
�� ߜzO�꼧ø ��J��)�!�,OA�4����t����FIwg�4�<  �$hK�@i������ߐ�Ӫ�Q�P��J�*l��rB�[.Y 3(�ށ-����!��q<�9K_�k�a���,@���^��w�1H],��H�|/ ͻ�ѻpl�&
Z�}ݡ9��p{}踿��d�ɖ�Kg��ڢ�K�b儕�-�)>ٰ^����c�S��P�!�ׁ�߷J�'�CI�����	
nm�� �],���@�"�x��=�=lX�X�uYI4�}r�*�V��^8~�sPY��z�|v��(��;��gC�k�v㬇��i\�yh����9Wϯ ^i�)ի��:9����7KztŜY���2���/����N�X5P�ԡ�eZ���i�p0�Q�s������	ihN�C�t��Z�:�.}x ~Y	x�:nx�v�$í�CtIi Z�װ����Rl�

�O�Qa�3J
�p�&Ë��yt�p��p8樳8�*Ĝ��������<����fCa�fY�x�R]�Tԩ��1+�+��� ɢ��sǸYTy�j���X|�V~G�3+CK;Jk�՝�i�v��zxQ��)��&�Zo���T�%<K�� �7�uI2E��|z�/t�(�T���z�-
#�h����^�
�1�%�z{�Џ����V��<�c��W���@;o�����{�}�u;�,�4���g<�m�I=����*e pԈgͫάA:���`�N���~�#��{�+zru���	�NJ��8�IPM�t�#��9²�8�`�*��b�p��:���<����w&�s|8�-���aҨ��V���L�{9���1s�jb�;��B�w6J�B����;,�=������v��'��^&ƻˌ�]*�D��z���5Ϊ�!#���%R{(]��Fص/4`S�0=u�rQ\Z7Wݼ߱Jw�7,Oc	}U�7=���;]� ���@N`�R#24�ZL��S5�AA�����S�������u�H`o(�ޙ�T�-0���p~n)�X�� /�fs<��	 �k-3} @�,�����ٲ�1���;�KޠY���h18UO`��� �1�k���Cu�z�Z�V��P�Ӊ�!g%HoS�G�C�iJ�`�D5Gj�hG7��&�'b^U(=�	!�I�j�
��8m�����4�~@##G���5��	��!{���S5��-�*i���Is�+����r��r~�X��C��F,���Qӹ��͗>�2c`� �sdh��Џ��W�^Z5\�\R���D�v���U���^*@z�B�i���� &M2 �p�^�Z�^0n��P�<#O[0�H���2���Fzn�Fcd@�l�NP���3�g�8��5��JQ�5@��L�.,
����0?}�|E���VLPK�T�7AY�X,��r�e�+/j���j_h)%gQG���7o �$�/{W��8Ҧ�g�hZ��g3|`��Jk�憄�V+_�ƀ���[U���N��Q��B��*���{T��7?.��ޟ�9Ծ�GQ�{RNDA��:�D`4�sV]�,�������Ԅ�Dg�^<�����7p����4�
�Ї�\�]�R��C?�c����nL��A7��V��QK��\�mZ��<�����V0cZ������ε��B�5<T|��_���q	���<1ǌV�d+
	O��xǗi|��Q���Z��!5(���B�h��|�^e�M�E���p�n�>>�2u��Chp��ɟ~�8��BCC�ގ	Ō��r�gҼ����^u�NM^��~�{�C1D:|C�s����W�JI+�Q��ʟ׍ W�?���#�+�ϥ�����^�!����d�A�aϜ�VSg��H�,�k���s٥�ʟ<�C
p2��P�r������ 	�{&zJ��͆g��h2�AC)yV����J�!���:t�0��Wm��NЇ�&C� ��u����U�Ѡ'�b�h����i�j@*���R�u��9?��,�;���#~~��c�X�J}E�~UY��I��ޠӲ���I� :�s���L�9���0���y��j{�S��k�����cI����r,��E�?��/��3D*���p��DqÓ�h��o4&��F6uSՇ�Lڼ�YS?�o��:ב�����s/}�� eY���\�~f��o()�I �7��������6��Wׇ_΃'´]���_���NN����~H��'��<P9����vx���� ���B�ߝ�|�:E|TWkyk�N�w�Amh�v�u}���A�o�Vؓ�9ހ���M�#������������6U!�������#:�Y��z��h��|jB54�6u�PZ�������#�
�Hȫ�3��S̇��q�7Bc�X{���W�Cc�"���#�F�i��ȫx���u��}I��*\\d8�Ҽ:��r��7���|��7k��&3sjϡ�Ha3Z�3)�>`����1DJM�Ab�z$J�������z��$�?��m�}�;��Z�d�}�
��p����cb����������ϠA��	�?�z2��y���5S�cX���
٥�D`Ww�	��ZM~E\ŗ�j�I���$ge�L*9���RO�>3\k��m%�;�� �x`.�g_�����]9����r7_�߼�Kڇ���Th�ᾒE��_�>1oM���� ���ܦ�f���݆�vj�A��4�#m�.w����q1�ꔲ���x<��z��v��<X�[�}���j���Y���D%�o��.�l��	��uB8�g@ ��ʡ�A�M\IK��u���GnxM�G�d�WP<��L.�����#����8���v�>���K_P?�.�
"�$f�sA��|�VΗ�o��߆@�ˊǔ��/m�8a���9\�a�g�>�Ϊ�BDA�!�+�@{6ݝ�(r�����'�9#�Ő�r��u�xz�ڷD�v�	nr?����wx��^|�z���T<g�'g����̀g�����3���3�y�{4�������
�qV.I�kv�۷�����u~�>)'V��p���N�Yw�-�K|��	�c,\�)�`<:�!}�T���e~ _n
x��C�i�'l��-�\�7���4�Ðο#���?QG�Yx9�G��aY�c�[�$8KPF�:�;��B����fF��2,����\3�p��BX���&4�.J'��i9����	�2^�S��gk��X��� |(J����a��4N&yu�P�wAҠ�^�-u;��ֵ ��դh�o� @r~j~b�M�a�l�;0��\��W�O%���v�W�O�	$G�ˑ:�e�x,�����,@�~ƙLBɆKWG�^�T��x�Í_^��\NL�N(�
W�w���R��9����J�$��b{�����
a):Q�k���C(��Ҟ��x
}�p"��$4���hnX���1�	%T������\��S���T\�:c���ː�H!)%V�B_�_*H �"J�3�飹:[���86XPt�.�8�/K����(��9��C\43��Q��N�T�������+��.ܟ�{��'��+�^~�e_��#x��bI����f~K����}z��O���bx�Ǜ۟!���>��&� ���?MR4n�(������?C1$n�(p��O�wŞ*��w��	�����>�KRu�H��H�D��s�������=����P|���	m��k�E�E����S�q�� ��ӗ��`��Q����A<+�� ���	���4�^�?��?
܌�y��i��I�0�S9=�R<�S<��ؔ�z��8�d5�2y�MӺ��Si���s>��~*D��/��#I��.�����S�$1�����R�,������(4$I�I{���TF芻^�d�M��,KS�[M�ܬ"�ĥ:��G>ٝF�1��֛��K~��ȓ�I��-)ʪ�J��r��r�c��q4��ɻ�`ۑ��2?��Tosג�{�N���jZj��g3w�����G/|ƭ+:����O�������z�G��Q�o��X�����������	n����o��sӺu]|F�@��R}��4��� >5���OM�vj�Gf4���G�̥����_�Z�sF���X����_���/��<��?
܎�O�c��������X��?���1��5+���Bu`��X�Vw��|�I�v]���'��gy?&��j�F�����Q�^�L"���^�+9	�U�j.��k@�v�X?\S��V�%/�^[�v�JSq	�3aȒ;����g+�Ӭ�Pi�ܼ��%�j�S��4Ԭ�\����>��:��.��ĕ�^ѯ4Qh*0'4􃷜x����[N\����H)nn�T���(&�B#'���R��x�S �F'�u�-����"n�E���bÕma@��;�����d%�k�m�E�t��n�R�+6Fl�}����}�irMWp��<(q{� ��ƪ��w	�gV̳=OZy>CV�I�n���TKPD��ٙE�����`3��Hh���]c>z\��rz�"4Nz����������������������`��s�q���������p+����x �?�����������y�q��p���!Z���z�+��������f���q��x!V�����#����7����>�Rt��sj����f��Z:�sj?Ef�>��iZ�h͙}�b��3�5p��_��q����?�r]��+�|���#W�9��ke[A(��d��V&����?Vr{#lʽ�85|.��b�!n��̘��ǻ����/�f^�N�t�i���S��	zҞP���[sU.��>�4'���LVG�㽈�����Q��8�G�����=�ǁ�q������� � 1�����������������_���/`��s�q���v���\�6�!�?��q3�.�������X�J�$9Z��W�@���wƿX���X��c�:��c�}l��@�+M�+P�fݪ(-rXK�Dz>�����hbt�rr/�>�j��j�ڂMuW�M�Ռ�z�1Ʋ�V��v�꛶P�s$aO��`Κ��e���Y�R�i��KP�Ϊ�H��iVp��n/Kd�"���Ͷ0Dv����l�T�	����͵z����?�m��%�z2'��l�$V&��9y�v��Y�Te!��#I�
-��V��{g���t8�؛U�$d��Fe���R�Q{�4�\�t�˜&���\���)y�)�B���)F!��"�wJ�O��#���q;D-������?�����?n�[�?v��������f��������k�H��UO�{��O�(,�G�8��8��������1G�����������X������� �ѩ+���/|��o�UVctU��4M�93��Ҽn�}�o�LF7���Pd:��X2C���'Y3C���T��E��@����f��	�����$q�XT�������tM��gC�/j��o��uy��^��A�Ȗ6p���,��v^�6C[��ϋ':i��Ƴn�t{���MG�w4���sdwo	dA��;%������9�p��m�c������o/syN�y���w��I���	>���a�߷�?�l��q��)�J��5|����%�D���ga�?���8�?M������#A�������A���1�ߜ��+��q��Hpc���A�������������3��^�	�����3d:C��Z�T���*��(��HCOe2�j�}�'S���}��dR�~_3�L:cR�Q�>D��o��rx�_4x���F6��]ٓ��\�9��ܕ���������JmE)�]���]t�������"�e�M��.��2�W�Rvbƹ�z'Z�Q��}��5{&�$ͥ�,k�-��T��i�Z�lt���M��}7�0�����/���?E����8���{���3<>��F���n��b�!��b/�q��	~����b���)T���l�k�t��I�rB��+�^�@�YޏI�q�}K�ڎ��l�"N"*愖��������7U5\il�Zmt�9խ��vV	f�%�ս�Wr����\^�v��N�kJ���B�˨�&�i��4W�ɒ;����g+�Ӭ�Pi�ܼ��%�j�S��4Ԭ�\��"T�r�h^ɤ���Q	[��b>)�چbD�٬���z`��d/�����ҹ�[J����X�3D1�V���1)>q��4��&����'�ǝ�*�6ړ�1�=�Ĩr�ɦ��SۋI��D
j�۾��D��'��B���Vl*޳mp�QL*�@�]e��(+f���>�7���s[�ۥinR����p��<�즾�:�r-�B�!	?@dQ�e%a�U�	/��;E�;�*Y*����ώ��f��������-�s'���q���e�_ϻy��/ıj��Yoq�|�:��R�w>�~�X�8���pc�qc`��s�������!6��.6|<b��_��H��Q�u�_Z��/�e��w�Sb��|�RT�Nv�����_��8�P�C���6@�`^��,��E�jAs�M:3[>�;�A�!���p�/����o���M6݂Sw6n���J��L��-i���lf��I��9���ъ�Z��ܶ!(�*�f[��y�:/��<��@�ן���[��Su_ ������~Ւz�U�PE�_Ֆ-u�t&Na���k����<���Ry��zr�]��wk�U'vZ�PPS�A��#%�[�׆����s�B�������?F���8����[���3W���_� &����7B,������������o������������8"����Ϧx��G�X�?�������?��c������?�2X��X���?����S�����"��RFJ�y������q$��f���C���f�V=Y���-���$��m�-�-�r�g;E�$��!)���C�`����$����^�=���^�C�D}��=�D5ӖT��ի��YU,&2��N+��MK;�t'���i:��ItR�R*���t+�٥�N��xV����N2�~̧K�����'�Y��<HZ���|�ec_,�ݾl�-�8J;�nCnKG�뗆��F�W��lo��?���նvT9�$�����Mv�t`f��X���=j�Ď/���?|SH<��J-�U��훗����e:Q��_��db���Py��Mʧ��������ȿ��TBA�.M]�Ƣ�/����?8���&�Ha�v@�9f3޲2��P�������
���)�)�$*=�0s��L<l�ݱϷ6FId���`�B�i��m�ӞN�R�<��s��:�3hzM�9�)�­{��]���౸��Q��C���Y�yX���R��z)
Qv;�36RO�c�޿u~�e}cP.a	݊p���@�n�E٬�}�R*w
e�Z����������K���g��2�Ѷ&]Q|��@3(w�Wژ��I������m��]��O�p����H$	��d�9P�瘖��b��HL���v�1�E$1w��mf����Q��U�e]S��s�����|�V.6�y���bԔb�XmVd�nca���`y�y}Qm��#Q�D&q�^�D!�í���P��剗[�w-,D��W��^�J�-�nKʱ��Q�D�l�5eا�1�VzEgn�^�㭚��R���}�
Il:�B `�6�L;���[���9�>����Z��2���k��P�_�ik��Vk%��ך�	_�7���|�?��f���:�/�j� ��9��Lh��B��VK{�9�@����aM�y3G��w�(����lb���1x��^ժ ?B�2M8Nl?A�Xh���y諨�;��v�a�tk��$�E�(sqy�l�#s�y.�Z�Z/慽o�]ݰ5��9��o|%��-#u��W��m�e=Gb���u��h�b�.ź���8P���5Wgz3'�,��̑R1���V���>�q��&���۬g��ky
�k�)�ÊP�I�P�[3��S��|Z`Az�Ru��L��#f��	"}q0  r��jC2�P#��/VD���M������ $�`� ~hʊ���}qxcj*9hRVM�wD�Y%�z�����N:��8(�ǃG�-�Yɟ(Vk|�x�/��%�ɿ�gu�^��ճ��.:�cMπA��O���/�?��u}�ԇԟݨ�J+�V�'���*�@���.v-�1}��,?�3�z��<�A������Vk�b�����O�� / r�Փ���i�~����X@Ճ� �O��ؿ<(�Yt86Ϛk��g#���k'�cw��V�m7�0`*���%t�N�뢅�Sy�.�k3�� �Xe�H�1��h���Prj���R�@/����Xd����BTj� �a)��\Xͅ�hp6K�=�ó�]��M�w�Z<�qB�[<�P?�֎* [{V�צq����0_PQ��ٵ����|!/�{�.�_��K�E���c��Ec��@3�78x[7H����K63N�6�	?+�[Y�e2]m��+�9�r��>���)�mf�����@cǨj�U�F"D��>/3\s籌	~�mt��^�x���G�G��|¬dvl%&�aO�6����T�`?�!R���βE^K���%�Yim	ז0�&�%�NY��&�i	h	�^�k�B�w?�^�?�hҨ���].\_����H%&��������ؗ!�%9OH5h�U�h�O�Q��d�4�����d�vQx��@w�/ނ1ɐ�Z�A�*9����D�	��"�*8P#PN��8.lZ�?�� ~u��D�ˈ���G�'2b9M��̈�����G��2�*��
5�����m�p���2qMĮN�\@�`��h����ȗ�SDӖS�[C�7^y�k/ ����p^ e!L���-Dr^���E��Z��^�R��Y8)����	��'��rT>)m
�E�?�� SƑ�m6l�>ЕeVs@%�#K�5�;_�t5�p�.(��l��@`�(r_6-�:�/l(
Epj�w�y
)�$��D��A�p7`�:Ռ o �$/�v�:��������xpý�\��� ����A�~�$����b��ϯd����a�O��z+�Y.���2�V�]j����_y�
VZg=���́�	B���OI@6��6oD�D}�$9�L4`��g�B�i�j@�5�r@��!r �"�<��ml�=�au�cNl����Po�r���n4����e���X֚3�Pkjd0�
tͦD�Ԩ��{�;nӚ�ځ c�h`,4��v°EmG�MD,V���9rb+��xe�1�PGE�;�D���ol��$2qp#b��=� q�m8�c1�t��nl�u@����1gî�8ͬ�X�4�8�DG��'�An�7��p�ۢ)`��`��8�­*���=E��$^�!�x���0�t�����7�&gj��?d[7\l*���C]������%�s�ښ.7%
^�P�!�Z�
��m}��KѧE��[�;��&����+�]���ې��Ȱ8�`���Mp�262= (Y>�;m4��ц�Nq�e�НE�nl��M���g�l^,���qY���ZA��Z�a[�Dn3��ġ�!T�!D�>.Ԡ� *�7�vm��tP����ca�CeX��#jGg���(��W	C	�jg�(��Q��V���D��VيLASE�5#��|�.�t?1	�3�g���̛�#kw[d8o^w�EY���=���p$j
q�p�=]1i�u]���^&�ˎ.����O����q;�b�p:��c��-�{�g�g��%T�i+ZC�a�w�Qu��X�Q�&wȭ6������,�.��賃�Ap �MJ��tp���F�8P$����Ȗ����hA\���܅� (2�����d	g�"/�͉ٙ=��h����� �0J�=�>�a��L{/���Ι����ÈX�Kd��- {�q��W��n�=�<�#fЭ=0�K��H�M��cuʈp�t$��3:=2wP�]��TZi�L�`��rFo�6����NY�?�D&���d*��^��<Dz��XKVc-��B�#��fёu��U�����.��,\|@��X� �"Kucpc ���[���d�/6��&�a{:��}!/6��Y��{&�a4E�Q�!~�7���r�Jl1߻G`�D���n�$-�t7�*.up!��{��.lqs�l�D; �8�[I�q��t�"��v��s�?�����{��I�����.�b��G�:o��	PO��r�m2��+�/�|�}Q%	�{ԛs�yQ���L̘���ߤ��:�c�b{J����<Hz���컻���,�4������=RV���"�:�k�Vp��Mu����}�;�/b�]�=Ya/yG���
��Y�ط��[�І��q� *���BEuu�dE�_�����H�l�?Od�I�����H���ގi[+�� x^�Y�%d�]jF�.b���j���`{￰�����ۃ"@a|pt����"��.�>.ɰ8>��2	`�*��u�Y3ȨGU'b���N�(cHٱH�t����Z��	�J����~��_������`�Bl�nfi��,�:6be�ҷ7'�M��#�z�i%�o������2X�-�"��Mg&��L6�X���H��Wqj�y��5��HT�
6�P�
_DK�Q�h���"|u�|�$���V�#�u5�y7Ƈߊ1�����"�Y�����ڊ�
��;2��nv�vw�[/3n���=>F~��ߕ�eYǰ�B;Z��[�Ң`���1'�	����[�*�𧴄���8���K���q��oW�Ǔ�����H���=7�,��Trr�'��^��I�>����0�����z_�����͟'K���'�S��Z�$=������R?{�vvk���m3!��������sjaSKW�iQ{�����s���2����^��>Hz�������sv`��n��',�|��l��\�0�!ۍ��%{E�XvQ�~>Ӯ�[]��i&E �����U�i�������_j;�~�ǃ�>��}C�����7��B���$���	y)�U�� �V�J��	��0�������� Ⱥ�*�ɱ����$1'�ͱ������^-�u��(a�5	�nHXp5���	0"S٧G�&�w���yf'%��������j����� ���1��vs�KP����*��A_�]�:@+�z�N���&/����2/&�q�Y�=��y*�3E����Zh?bZe��^��O�����I�������������
��������?��N���PVڄE���f���ygÝ�z�����qw/إP�+�ˮc*D�/�̂���]�3���W-=����愇���ϗ*<�o��c��x�y��+��Lb}�Ã�g Rl��M�� ���_/�~/�����O��HM��f�'X��C$��[��1�\|��!~V;'2A��#��+T����j�A��%NvX'+����:��9a���'$@%=�	��w
��Q��=��^�DZ����8�_
�O�D`j���$TUa�P`���	w�~I�i.�Y����"�%�T)��IÍ�f
/sN(��$���m1��6�l �� �����fO�Y��,h�
0,�n1�&��y#Mo�҅��vE���M�;���[��x�U%�bU[��ߒa]C⌎���je߭R3��k����ax8�-v�.l{b�Y�u�'_3��ݡ�l?�*�,v�a�t)�;�Oq�c�07�}'[E	.��}E0�v��D�S'��e��_+�����O����Y�?�Jd���d&�H$�`D�X��<H
����������������wY��?k%:��x:��M@�w�D+���lo��;��HS�b&��v:qpWw��DZ�NHi)%A�4}JB?��ƞ��O����?������:��������������˧�9
��(4n��_=��p���{���c��o
��\��?~��?}����ϟ���O����~����X��d��#(|ޝz������죑�n���r���'�T�ҨrYU�W��K~t�����������R~�-�J�rP��^������S�ݩ�x9_8�����^<��Wg���R�K�O�${�����⍰�LJ����V��+��|�?O}�F�]�dk�M����u蒯�7^�k�v���e��g����U������󯠛���ޫ���_l�W��oC7�t�3��tb����Aoj�z��Ð�G�.*1� ��*�Ĳ��ǻ�
V,�*�_wKB�~{3�������O��7i���u��.=�z�洣v��j�6>H탥;1^^�v$����d���A���\^���v1���O��G��xT�i-��k��w�o�Z�z����/J�z���<�Ho.�c���B�Rl4*7��|��=i �z���:P��aC�ٿ̟YeR�Ԁ2�p���Ë���"�s�_��V/&������8n��ni�ӷ��Y�J�S
�H]Ў*�q>*}�N;q�|
$�q>�ĉ���iR�8�PoHR%��*NHp�T�T��*!D�����$�Lfvwvf5�V��{�����{�/��{y��4szO�6-�u,,M��<ه�İ���N�͂s3����I|գ}�^ި�h�T)/����z�um�Z��Z/9�������\�����Z-G�|?ݪ�d[�S��5q�k˞mx�'��m�l��P��[�N6��(�4��%�re¼\�ԉ9pm���ո0r�z��;	
�l�qKnU���P�%]��S�)>e-��s��`˰=�W�d#��+���+"�VT������1؅�jU�q�a��Rf��C���B^Z��E�%�˃��0�ҦhJ.��2���j�������=.S�F��	帣	��@q�uA.�Wh�d(�)-֍Ӛ�'�0��FL3��T���1fX�m�Q��i�`~ٓ�Q���\.��fĽ~u��/[�P�$�+�,w��ufa�c#,�y	&V6���|�SF��*��Lc���j��D�t��qZ��B�m�|R@�6a(�M�V}L'�5�����!�q{�T(�X�Hs�w]Sr��Er�˩�0[�-
}���)�D��ZW�8df��D?b��-����!���
n��p���܌���
d|�9�f�b�Ү�2<�����h;Q�f!������gD�����d�#��L��-���p���
�>Xca��X�K:\�+Ng��ժ��P����a���y��D���d%��}�-QگkD�k0%6Q��[=�*g�VHk�c�X�ٳ&����T,��T,���r�	DI�bJ	�V�c9�|H���"�"��U<2�9ڙ)�_�ɢ�H�	/���I-H,�e�7+��P�I�J�H���8Q�)��[nfñ�����MC��K�v����X�㍥scȔk("��Dr\8�S[3���p֜�N�X/'�x��F�}'���*���8��F��e����D��2����ʶ�Ԍ�Qr��@6�+�P�P��c9�|H��Ƣ0{xԏ%7��ڞdVG&.�3Ur+�v��h�U�T$��m���Z�a��zNo��i���;�ūٖV㉙�d+��r��좚�l�f;YͶs���%�c�Q{l��K���a;�v>�|x록K�����F�����t?��f���f�����8խv�OP󟵟�DL���1�h8�9k��%z��rs��ϰ��p��}&�e-O�|\���߼�ܲ`�b[��H����Luf�6v<���Ze<��M��ؓ؅-�}��[ĵ�7�[����\�.m}���^�� �PsI�ڍEϱ��������ظ�z��:�'6uV�x��`o]�r��߸���́�Śg�w�(���`4�3��v�k �G��l'�:&��_�+W���'�����߷��
�C��
^�k��[ϮR�"�9���D����>;MG��A�]�eJ��z��x�M��>�J���ES���9G+ׂT��*[�(e��=I.��I���@��h�S�0G�%��1�o�.�F0�*-P�:�S�
`T��)0��ӯ��Ҡ¨��\*H��s������4��f���XT���p�m�w{��B6d��D�����*\t�x;�kVrJ*I������~���q��5eʜVZ��J�D���6ۑ��^�u*>Ր`da����q��;0���<y��Ϗ��l�����"e���q���ۖ�Q`B�h� ��D3���~BR�EN�&J���Rix�L���}�l��F�>�Cj����Rw��f�ON��'�)��FiN$F%��n��pl��F~�ƪ�n"�Km���S~�s�"�@΁��.ul�Jz{&(*��(./����d�Ūf:ab]�}{6P|z��E�º�Aͻ���w������:&�����V��TXI��A�N�D
��֭��,Q��U�N"����<*�-8r�,E���r��<��0p��ȪW`	�lvkó��|�Z�!G�pQF=[N�r�0�b8ʚQ|6��8��~(I(�О�8�k��ZHL� S���e1���`곳��|5gb�d��&r�C��<��p�N�z���Z�g���P�'�(F�����1A�Gv�T"k,$�Fw+��8̛1��5�V��ƀ*�|>���L��*�q%H"R#=({�a���-9mA���N�S-���4C�N�3�TX�9�s��9ǩ���a��DEY��E١'��Nɝ f�y<���m�	�3�J�0M��d�@������}D6�Z'����j��Ū���u��Qh���+�z�m������O4*/܂�λ��#���C�2�E�fv���o?J��~�k��ޏ�}��<��w���'_�w�f_[����!9,cw0��z�̺u������$�G���X�?ݝ��|���4}��?�ͷ�+^�\}�GW���k�������G��f�����������֯\�s���>�n`;ص3�<��/�����'����,j|�~�5�/"�@��$bޠv���}t���>�v"j'�v"� �	 j'z��i�� iH#j'�v"j'��P��i�v��oy��7NA�<	4��s��0T�z��=s;B��C�o=cb�j��?!��:��5��PY�x�U*z��x�9�s<0��=p$�5p?���냍e6w��К���53hY Z��� �@�q����z�{Xs?V��8k���Ii��]���9ϊ_��-���$H� A�	$H� A�	$H� A�	��.���ph   